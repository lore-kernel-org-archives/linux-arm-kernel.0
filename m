From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 20 Dec 2017 03:01:56 +0800
Subject: [RFC PATCH xlnx] staging: xilinx: Si5324_RatApprox() can be static
In-Reply-To: <201712200342.PY8E7FkU%fengguang.wu@intel.com>
References: <201712200342.PY8E7FkU%fengguang.wu@intel.com>
Message-ID: <20171219190156.GA22920@lkp-wsm-ep1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: b58dab7f9cf1 ("staging: xilinx: Add xilinx hdmi drivers to staging area")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 clk/si5324drv.c                        |    2 +-
 hdmi/phy-xilinx-vphy/aes256.c          |   24 ++++++++++++------------
 hdmi/phy-xilinx-vphy/bigdigits.c       |    2 +-
 hdmi/phy-xilinx-vphy/xdebug.c          |    6 +++---
 hdmi/phy-xilinx-vphy/xhdcp22_tx.c      |    4 ++--
 hdmi/phy-xilinx-vphy/xvidc.c           |    4 ++--
 hdmi/phy-xilinx-vphy/xvphy_gthe4.c     |   16 ++++++++--------
 hdmi/phy-xilinx-vphy/xvphy_hdmi_intr.c |   22 +++++++++++-----------
 hdmi/xilinx-hdmi-rx/xv_hdmirx.c        |    4 ++--
 hdmi/xilinx-hdmi-rx/xv_hdmirx_vsif.c   |    2 +-
 hdmi/xilinx-hdmi-rx/xv_hdmirxss.c      |    4 ++--
 hdmi/xilinx-hdmi-tx/xv_hdmitx.c        |    2 +-
 hdmi/xilinx-hdmi-tx/xv_hdmitx_vsif.c   |    4 ++--
 hdmi/xilinx-hdmi-tx/xv_hdmitxss.c      |    4 ++--
 hdmi/xilinx_drm_hdmi.c                 |    4 ++--
 misc/dp159.c                           |    8 ++++----
 16 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/xilinx/clk/si5324drv.c b/drivers/staging/xilinx/clk/si5324drv.c
index 9e2a519..d7f4e45 100644
--- a/drivers/staging/xilinx/clk/si5324drv.c
+++ b/drivers/staging/xilinx/clk/si5324drv.c
@@ -14,7 +14,7 @@
  * @param num Will store the numinator (N2_LS) found.
  * @param denom Will store the denominator (N3) found.
  */
-void Si5324_RatApprox(u64 f, u64 md, u32 *num, u32 *denom)
+static void Si5324_RatApprox(u64 f, u64 md, u32 *num, u32 *denom)
 {
     /*  a: Continued fraction coefficients. */
     u64 a, h[3] = { 0, 1, 0 }, k[3] = { 1, 0, 0 };
diff --git a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/aes256.c b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/aes256.c
index e3c502f..4eeb952 100644
--- a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/aes256.c
+++ b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/aes256.c
@@ -72,7 +72,7 @@ const uint8_t sbox[256] = {
     0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68,
     0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16
 };
-const uint8_t sboxinv[256] = {
+static const uint8_t sboxinv[256] = {
     0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38,
     0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb,
     0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87,
@@ -169,13 +169,13 @@ uint8_t rj_sbox_inv(uint8_t x)
 #endif
 
 /* -------------------------------------------------------------------------- */
-uint8_t rj_xtime(uint8_t x) 
+static uint8_t rj_xtime(uint8_t x) 
 {
     return (x & 0x80) ? ((x << 1) ^ 0x1b) : (x << 1);
 } /* rj_xtime */
 
 /* -------------------------------------------------------------------------- */
-void aes_subBytes(uint8_t *buf)
+static void aes_subBytes(uint8_t *buf)
 {
     register uint8_t i = 16;
 
@@ -183,7 +183,7 @@ void aes_subBytes(uint8_t *buf)
 } /* aes_subBytes */
 
 /* -------------------------------------------------------------------------- */
-void aes_subBytes_inv(uint8_t *buf)
+static void aes_subBytes_inv(uint8_t *buf)
 {
     register uint8_t i = 16;
 
@@ -191,7 +191,7 @@ void aes_subBytes_inv(uint8_t *buf)
 } /* aes_subBytes_inv */
 
 /* -------------------------------------------------------------------------- */
-void aes_addRoundKey(uint8_t *buf, uint8_t *key)
+static void aes_addRoundKey(uint8_t *buf, uint8_t *key)
 {
     register uint8_t i = 16;
 
@@ -199,7 +199,7 @@ void aes_addRoundKey(uint8_t *buf, uint8_t *key)
 } /* aes_addRoundKey */
 
 /* -------------------------------------------------------------------------- */
-void aes_addRoundKey_cpy(uint8_t *buf, uint8_t *key, uint8_t *cpk)
+static void aes_addRoundKey_cpy(uint8_t *buf, uint8_t *key, uint8_t *cpk)
 {
     register uint8_t i = 16;
 
@@ -208,7 +208,7 @@ void aes_addRoundKey_cpy(uint8_t *buf, uint8_t *key, uint8_t *cpk)
 
 
 /* -------------------------------------------------------------------------- */
-void aes_shiftRows(uint8_t *buf)
+static void aes_shiftRows(uint8_t *buf)
 {
     register uint8_t i, j; /* to make it potentially parallelable :) */
 
@@ -220,7 +220,7 @@ void aes_shiftRows(uint8_t *buf)
 } /* aes_shiftRows */
 
 /* -------------------------------------------------------------------------- */
-void aes_shiftRows_inv(uint8_t *buf)
+static void aes_shiftRows_inv(uint8_t *buf)
 {
     register uint8_t i, j; /* same as above :) */
 
@@ -232,7 +232,7 @@ void aes_shiftRows_inv(uint8_t *buf)
 } /* aes_shiftRows_inv */
 
 /* -------------------------------------------------------------------------- */
-void aes_mixColumns(uint8_t *buf)
+static void aes_mixColumns(uint8_t *buf)
 {
     register uint8_t i, a, b, c, d, e;
 
@@ -246,7 +246,7 @@ void aes_mixColumns(uint8_t *buf)
 } /* aes_mixColumns */
 
 /* -------------------------------------------------------------------------- */
-void aes_mixColumns_inv(uint8_t *buf)
+static void aes_mixColumns_inv(uint8_t *buf)
 {
     register uint8_t i, a, b, c, d, e, x, y, z;
 
@@ -262,7 +262,7 @@ void aes_mixColumns_inv(uint8_t *buf)
 } /* aes_mixColumns_inv */
 
 /* -------------------------------------------------------------------------- */
-void aes_expandEncKey(uint8_t *k, uint8_t *rc) 
+static void aes_expandEncKey(uint8_t *k, uint8_t *rc) 
 {
     register uint8_t i;
 
@@ -285,7 +285,7 @@ void aes_expandEncKey(uint8_t *k, uint8_t *rc)
 } /* aes_expandEncKey */
 
 /* -------------------------------------------------------------------------- */
-void aes_expandDecKey(uint8_t *k, uint8_t *rc) 
+static void aes_expandDecKey(uint8_t *k, uint8_t *rc) 
 {
     uint8_t i;
 
diff --git a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/bigdigits.c b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/bigdigits.c
index 9235176..37f2671 100644
--- a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/bigdigits.c
+++ b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/bigdigits.c
@@ -44,7 +44,7 @@
 #endif
 
 /* Added in [v2.4] for ALLOC_BYTES and FREE_BYTES */
-volatile uint8_t zeroise_bytes(volatile void *v, size_t n)
+static volatile uint8_t zeroise_bytes(volatile void *v, size_t n)
 {	/* Zeroise byte array b and make sure optimiser does not ignore this */
 	volatile uint8_t optdummy;
 	volatile uint8_t *b = (uint8_t*)v;
diff --git a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xdebug.c b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xdebug.c
index 4d2e9cc..de7fd51 100644
--- a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xdebug.c
+++ b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xdebug.c
@@ -24,9 +24,9 @@ XDebug_Printf xdebugPrintf = NULL;	/**< Instance of function
 											  *  interface used for debug
 											  *  print statement */
 
-char *xdebugBuff = NULL;
-int xdebugBuffSize = 0;
-int *xdebugBuffPos = NULL;
+static char *xdebugBuff = NULL;
+static int xdebugBuffSize = 0;
+static int *xdebugBuffPos = NULL;
 
 static void XDebug_DebugBufPrintf(const char *fmt, ...)
 {
diff --git a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx.c b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx.c
index 5b21f71..0da569f 100644
--- a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx.c
+++ b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx.c
@@ -213,7 +213,7 @@ static u32 XHdcp22Tx_GetTopologyHdcp1DeviceDownstream(XHdcp22_Tx *InstancePtr);
 * This table contains the function pointers for all possible states.
 * The order of elements must match the #XHdcp22_Tx_StateType enumerator definitions.
 */
-XHdcp22Tx_StateFuncType* const XHdcp22_Tx_StateTable[XHDCP22_TX_NUM_STATES] =
+static XHdcp22Tx_StateFuncType* const XHdcp22_Tx_StateTable[XHDCP22_TX_NUM_STATES] =
 {
 	XHdcp22Tx_StateH0, XHdcp22Tx_StateH1, XHdcp22Tx_StateA0,
 	XHdcp22Tx_StateA1, Xhdcp22Tx_StateA1_1,
@@ -1672,7 +1672,7 @@ static XHdcp22_Tx_StateType XHdcp22Tx_StateA1(XHdcp22_Tx *InstancePtr)
 * @note   None.
 *
 ******************************************************************************/
-XHdcp22_Tx_StateType Xhdcp22Tx_StateA1_1(XHdcp22_Tx *InstancePtr)
+static XHdcp22_Tx_StateType Xhdcp22Tx_StateA1_1(XHdcp22_Tx *InstancePtr)
 {
 	int Result = XST_SUCCESS;
 	XHdcp22_Tx_DDCMessage *MsgPtr = (XHdcp22_Tx_DDCMessage *)InstancePtr->MessageBuffer;
diff --git a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvidc.c b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvidc.c
index 647d61d..5b38cad 100644
--- a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvidc.c
+++ b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvidc.c
@@ -61,8 +61,8 @@
 /*************************** Variable Declarations ****************************/
 extern const XVidC_VideoTimingMode XVidC_VideoTimingModes[XVIDC_VM_NUM_SUPPORTED];
 
-const XVidC_VideoTimingMode *XVidC_CustomTimingModes = NULL;
-int XVidC_NumCustomModes = 0;
+static const XVidC_VideoTimingMode *XVidC_CustomTimingModes = NULL;
+static int XVidC_NumCustomModes = 0;
 
 /**************************** Function Prototypes *****************************/
 
diff --git a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvphy_gthe4.c b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvphy_gthe4.c
index 4827c87..ade5968 100644
--- a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvphy_gthe4.c
+++ b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvphy_gthe4.c
@@ -122,20 +122,20 @@ u32 XVphy_Gthe4RxPllRefClkDiv1Reconfig(XVphy *InstancePtr, u8 QuadId,
 #define XVPHY_CPLL_MIN		 2000000000LL
 #define XVPHY_CPLL_MAX		 6250000000LL
 
-const u8 Gthe4CpllDivsM[]	= {1, 2, 0};
-const u8 Gthe4CpllDivsN1[]	= {4, 5, 0};
+static const u8 Gthe4CpllDivsM[]	= {1, 2, 0};
+static const u8 Gthe4CpllDivsN1[]	= {4, 5, 0};
 #if (XPAR_VPHY_0_TX_PROTOCOL == 0 || XPAR_VPHY_0_RX_PROTOCOL == 0)
 const u8 Gthe4CpllDivsN2[]	= {1, 2, 3, 4, 5, 8, 0};
 #else
-const u8 Gthe4CpllDivsN2[]	= {1, 2, 3, 4, 5, 0};
+static const u8 Gthe4CpllDivsN2[]	= {1, 2, 3, 4, 5, 0};
 #endif
-const u8 Gthe4CpllDivsD[]	= {1, 2, 4, 8, 0};
+static const u8 Gthe4CpllDivsD[]	= {1, 2, 4, 8, 0};
 
-const u8 Gthe4QpllDivsM[]	= {4, 3, 2, 1, 0};
-const u8 Gthe4QpllDivsN1[]	= {16, 20, 32, 40, 60, 64, 66, 75, 80, 84, 90,
+static const u8 Gthe4QpllDivsM[]	= {4, 3, 2, 1, 0};
+static const u8 Gthe4QpllDivsN1[]	= {16, 20, 32, 40, 60, 64, 66, 75, 80, 84, 90,
 				   96, 100, 112, 120, 125, 150, 160, 0};
-const u8 Gthe4QpllDivsN2[]	= {1, 0};
-const u8 Gthe4QpllDivsD[]	= {16, 8, 4, 2, 1, 0};
+static const u8 Gthe4QpllDivsN2[]	= {1, 0};
+static const u8 Gthe4QpllDivsD[]	= {16, 8, 4, 2, 1, 0};
 
 const XVphy_GtConfig Gthe4Config = {
 	.CfgSetCdr = XVphy_Gthe4CfgSetCdr,
diff --git a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvphy_hdmi_intr.c b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvphy_hdmi_intr.c
index 9ae61db..9e23f31 100644
--- a/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvphy_hdmi_intr.c
+++ b/drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvphy_hdmi_intr.c
@@ -202,7 +202,7 @@ void XVphy_HdmiIntrHandlerCallbackInit(XVphy *InstancePtr)
 * @note		None.
 *
 ******************************************************************************/
-void XVphy_HdmiQpllLockHandler(XVphy *InstancePtr)
+static void XVphy_HdmiQpllLockHandler(XVphy *InstancePtr)
 {
 	XVphy_PllType TxPllType;
 	XVphy_PllType RxPllType;
@@ -421,7 +421,7 @@ void XVphy_HdmiGtpPllLockHandler(XVphy *InstancePtr, u8 Pll)
 * @note		None.
 *
 ******************************************************************************/
-void XVphy_HdmiCpllLockHandler(XVphy *InstancePtr)
+static void XVphy_HdmiCpllLockHandler(XVphy *InstancePtr)
 {
 	XVphy_PllType TxPllType;
 	XVphy_PllType RxPllType;
@@ -520,7 +520,7 @@ void XVphy_HdmiCpllLockHandler(XVphy *InstancePtr)
 * @note		None.
 *
 ******************************************************************************/
-void XVphy_HdmiGtTxResetDoneLockHandler(XVphy *InstancePtr)
+static void XVphy_HdmiGtTxResetDoneLockHandler(XVphy *InstancePtr)
 {
 	u8 Id, Id0, Id1;
 
@@ -570,7 +570,7 @@ void XVphy_HdmiGtTxResetDoneLockHandler(XVphy *InstancePtr)
 * @note		None.
 *
 ******************************************************************************/
-void XVphy_HdmiGtTxAlignDoneLockHandler(XVphy *InstancePtr)
+static void XVphy_HdmiGtTxAlignDoneLockHandler(XVphy *InstancePtr)
 {
 	u8 Id, Id0, Id1;
 
@@ -605,7 +605,7 @@ void XVphy_HdmiGtTxAlignDoneLockHandler(XVphy *InstancePtr)
 * @note		None.
 *
 ******************************************************************************/
-void XVphy_HdmiGtRxResetDoneLockHandler(XVphy *InstancePtr)
+static void XVphy_HdmiGtRxResetDoneLockHandler(XVphy *InstancePtr)
 {
 	u8 Id, Id0, Id1;
 
@@ -654,7 +654,7 @@ void XVphy_HdmiGtRxResetDoneLockHandler(XVphy *InstancePtr)
 * @note		None.
 *
 ******************************************************************************/
-void XVphy_HdmiTxClkDetFreqChangeHandler(XVphy *InstancePtr)
+static void XVphy_HdmiTxClkDetFreqChangeHandler(XVphy *InstancePtr)
 {
 	XVphy_PllType PllType;
 	u8 Id, Id0, Id1;
@@ -741,7 +741,7 @@ void XVphy_HdmiTxClkDetFreqChangeHandler(XVphy *InstancePtr)
 * @note		None.
 *
 ******************************************************************************/
-void XVphy_HdmiRxClkDetFreqChangeHandler(XVphy *InstancePtr)
+static void XVphy_HdmiRxClkDetFreqChangeHandler(XVphy *InstancePtr)
 {
 	XVphy_PllType PllType;
 	u32 RxRefClkHz;
@@ -836,7 +836,7 @@ void XVphy_HdmiRxClkDetFreqChangeHandler(XVphy *InstancePtr)
 * @note		None.
 *
 ******************************************************************************/
-void XVphy_HdmiTxTimerTimeoutHandler(XVphy *InstancePtr)
+static void XVphy_HdmiTxTimerTimeoutHandler(XVphy *InstancePtr)
 {
 	XVphy_ChannelId ChId;
 	XVphy_PllType PllType;
@@ -944,7 +944,7 @@ void XVphy_HdmiTxTimerTimeoutHandler(XVphy *InstancePtr)
 * @note		None.
 *
 ******************************************************************************/
-void XVphy_HdmiRxTimerTimeoutHandler(XVphy *InstancePtr)
+static void XVphy_HdmiRxTimerTimeoutHandler(XVphy *InstancePtr)
 {
 	XVphy_ChannelId ChId;
 	XVphy_PllType PllType;
@@ -1133,7 +1133,7 @@ void XVphy_HdmiTxMmcmLockHandler(XVphy *InstancePtr)
 * @note		None.
 *
 ******************************************************************************/
-void XVphy_HdmiGtHandler(XVphy *InstancePtr)
+static void XVphy_HdmiGtHandler(XVphy *InstancePtr)
 {
 	u32 Event;
 	u32 EventMask;
@@ -1209,7 +1209,7 @@ void XVphy_HdmiGtHandler(XVphy *InstancePtr)
 * @note		None.
 *
 ******************************************************************************/
-void XVphy_ClkDetHandler(XVphy *InstancePtr)
+static void XVphy_ClkDetHandler(XVphy *InstancePtr)
 {
 	u32 Event;
 	u32 EventMask;
diff --git a/drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.c b/drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.c
index 803030a1..3be878f 100644
--- a/drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.c
+++ b/drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.c
@@ -708,7 +708,7 @@ u32 XV_HdmiRx_GetAcrN(XV_HdmiRx *InstancePtr)
 * @note     None.
 *
 ******************************************************************************/
-u16 XV_HdmiRx_DdcGetEdidWords(XV_HdmiRx *InstancePtr)
+static u16 XV_HdmiRx_DdcGetEdidWords(XV_HdmiRx *InstancePtr)
 {
     u32 Data;
 
@@ -1240,7 +1240,7 @@ u32 XV_HdmiRx_Divide(u32 Dividend, u32 Divisor)
 * @note     None.
 *
 ******************************************************************************/
-XVidC_VideoMode XV_HdmiRx_LookupVmId(u8 Vic)
+static XVidC_VideoMode XV_HdmiRx_LookupVmId(u8 Vic)
 {
     XV_HdmiRx_VicTable const *Entry;
     u8 Index;
diff --git a/drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_vsif.c b/drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_vsif.c
index 25d3c4c..156618a 100644
--- a/drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_vsif.c
+++ b/drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_vsif.c
@@ -340,7 +340,7 @@ int XV_HdmiRx_VSIF_ParsePacket(XV_HdmiRx_Aux *AuxPtr, XV_HdmiRx_VSIF  *VSIFPtr)
 *  - XST_FAILURE if an error was detected during parsing
 *
 ******************************************************************************/
-int XV_HdmiRx_VSIF_Extract3DInfo(u8 *VSIFRaw, XV_HdmiRx_3D_Info *InstancePtr)
+static int XV_HdmiRx_VSIF_Extract3DInfo(u8 *VSIFRaw, XV_HdmiRx_3D_Info *InstancePtr)
 {
     u8 *pData;
     u8 temp;
diff --git a/drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss.c b/drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss.c
index 5201425..993924a 100644
--- a/drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss.c
+++ b/drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss.c
@@ -111,7 +111,7 @@ typedef struct
 
 /**************************** Local Global ***********************************/
 /** Define Driver instance of all sub-core included in the design */
-XV_HdmiRxSs_SubCores XV_HdmiRxSs_SubCoreRepo[XPAR_XV_HDMIRXSS_NUM_INSTANCES];
+static XV_HdmiRxSs_SubCores XV_HdmiRxSs_SubCoreRepo[XPAR_XV_HDMIRXSS_NUM_INSTANCES];
 
 /************************** Function Prototypes ******************************/
 static void XV_HdmiRxSs_GetIncludedSubcores(XV_HdmiRxSs *HdmiRxSsPtr,
@@ -1680,7 +1680,7 @@ static void XV_HdmiRxSs_ReportInfoFrame(XV_HdmiRxSs *InstancePtr)
 * @note   None.
 *
 ******************************************************************************/
-void XV_HdmiRxSs_ReportSubcoreVersion(XV_HdmiRxSs *InstancePtr)
+static void XV_HdmiRxSs_ReportSubcoreVersion(XV_HdmiRxSs *InstancePtr)
 {
   u32 Data;
 
diff --git a/drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx.c b/drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx.c
index 1e5a301..f36eef07 100644
--- a/drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx.c
+++ b/drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx.c
@@ -352,7 +352,7 @@ void XV_HdmiTx_Clear(XV_HdmiTx *InstancePtr)
 * @note     None.
 *
 ******************************************************************************/
-u8 XV_HdmiTx_LookupVic(XVidC_VideoMode VideoMode)
+static u8 XV_HdmiTx_LookupVic(XVidC_VideoMode VideoMode)
 {
     XV_HdmiTx_VicTable const *Entry;
     u8 Index;
diff --git a/drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx_vsif.c b/drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx_vsif.c
index 805d99a..c187591 100644
--- a/drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx_vsif.c
+++ b/drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx_vsif.c
@@ -287,7 +287,7 @@ static XVidC_3DSamplingPosition XV_HdmiTx_VSIF_Conv3DSampPosTo3DSampPos(XV_HdmiT
 *  - XST_FAILURE if an error was detected during parsing
 *
 ******************************************************************************/
-int XV_HdmiTx_VSIF_ParsePacket(XV_HdmiTx_Aux *AuxPtr, XV_HdmiTx_VSIF  *VSIFPtr)
+static int XV_HdmiTx_VSIF_ParsePacket(XV_HdmiTx_Aux *AuxPtr, XV_HdmiTx_VSIF  *VSIFPtr)
 {
     u8 *pData;
     u32 temp;
@@ -361,7 +361,7 @@ int XV_HdmiTx_VSIF_ParsePacket(XV_HdmiTx_Aux *AuxPtr, XV_HdmiTx_VSIF  *VSIFPtr)
 *  - XST_FAILURE if an error was detected during parsing
 *
 ******************************************************************************/
-int XV_HdmiTx_VSIF_Extract3DInfo(u8 *VSIFRaw, XV_HdmiTx_3D_Info *InstancePtr)
+static int XV_HdmiTx_VSIF_Extract3DInfo(u8 *VSIFRaw, XV_HdmiTx_3D_Info *InstancePtr)
 {
     u8 *pData;
     u8 temp;
diff --git a/drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitxss.c b/drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitxss.c
index 1d02c74..7f40186 100644
--- a/drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitxss.c
+++ b/drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitxss.c
@@ -153,7 +153,7 @@ typedef struct
 }XV_HdmiTxSs_SubCores;
 
 /**************************** Local Global ***********************************/
-XV_HdmiTxSs_SubCores XV_HdmiTxSs_SubCoreRepo[XPAR_XV_HDMITXSS_NUM_INSTANCES];
+static XV_HdmiTxSs_SubCores XV_HdmiTxSs_SubCoreRepo[XPAR_XV_HDMITXSS_NUM_INSTANCES];
                 /**< Define Driver instance of all sub-core
                                     included in the design */
 
@@ -2069,7 +2069,7 @@ void XV_HdmiTxSs_RefClockChangeInit(XV_HdmiTxSs *InstancePtr)
 * @note   None.
 *
 ******************************************************************************/
-void XV_HdmiTxSs_ReportTiming(XV_HdmiTxSs *InstancePtr)
+static void XV_HdmiTxSs_ReportTiming(XV_HdmiTxSs *InstancePtr)
 {
       if (((u32) XV_HdmiTx_GetMode(InstancePtr->HdmiTxPtr)) == 0) {
         xil_printf("HDMI TX Mode - DVI \r\n");
diff --git a/drivers/staging/xilinx/hdmi/xilinx_drm_hdmi.c b/drivers/staging/xilinx/hdmi/xilinx_drm_hdmi.c
index 34ee632..e1fd1ed 100644
--- a/drivers/staging/xilinx/hdmi/xilinx_drm_hdmi.c
+++ b/drivers/staging/xilinx/hdmi/xilinx_drm_hdmi.c
@@ -522,7 +522,7 @@ static void TxStreamDownCallback(void *CallbackRef)
 	hdcp_protect_content(xhdmi);
 }
 
-void TxHdcpAuthenticatedCallback(void *CallbackRef)
+static void TxHdcpAuthenticatedCallback(void *CallbackRef)
 {
 	struct xilinx_drm_hdmi *xhdmi = (struct xilinx_drm_hdmi *)CallbackRef;
 	XV_HdmiTxSs *HdmiTxSsPtr;
@@ -549,7 +549,7 @@ void TxHdcpAuthenticatedCallback(void *CallbackRef)
 	}
 }
 
-void TxHdcpUnauthenticatedCallback(void *CallbackRef)
+static void TxHdcpUnauthenticatedCallback(void *CallbackRef)
 {
 	struct xilinx_drm_hdmi *xhdmi = (struct xilinx_drm_hdmi *)CallbackRef;
 	XV_HdmiTxSs *HdmiTxSsPtr;
diff --git a/drivers/staging/xilinx/misc/dp159.c b/drivers/staging/xilinx/misc/dp159.c
index 368b0ff..33a2b5b 100644
--- a/drivers/staging/xilinx/misc/dp159.c
+++ b/drivers/staging/xilinx/misc/dp159.c
@@ -98,7 +98,7 @@ static int dp159_program(struct i2c_client *client, unsigned long rate)
 
 #define to_clk_tx_linerate(_hw) container_of(_hw, struct clk_tx_linerate, hw)
 
-int clk_tx_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate)
+static int clk_tx_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate)
 {
 	struct clk_tx_linerate *clk;
 	clk = to_clk_tx_linerate(hw);
@@ -108,7 +108,7 @@ int clk_tx_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_
 	return 0;
 };
 
-unsigned long clk_tx_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+static unsigned long clk_tx_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	struct clk_tx_linerate *clk;
 	clk = to_clk_tx_linerate(hw);
@@ -116,7 +116,7 @@ unsigned long clk_tx_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return clk->rate;
 };
 
-long clk_tx_round_rate(struct clk_hw *hw,
+static long clk_tx_round_rate(struct clk_hw *hw,
 	unsigned long rate,	unsigned long *parent_rate)
 {
 	struct clk_tx_linerate *clk;
@@ -124,7 +124,7 @@ long clk_tx_round_rate(struct clk_hw *hw,
 	return rate;
 };
 
-struct clk_ops clk_tx_rate_ops = {
+static struct clk_ops clk_tx_rate_ops = {
 	.set_rate 		= &clk_tx_set_rate,
 	.recalc_rate	= &clk_tx_recalc_rate,
 	.round_rate		= &clk_tx_round_rate,
