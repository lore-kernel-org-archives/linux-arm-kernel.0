From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Jun 2013 12:06:49 +0200
Subject: [PATCH 01/23] ARM: tegra: Create a DT header defining swgroups ID
In-Reply-To: <1372238906-9346-2-git-send-email-hdoyu@nvidia.com>
References: <1372238906-9346-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130626100648.GC27083@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:28:04PM +0300, Hiroshi Doyu wrote:
[...]
> +#define SWGID_AFI 0
> +#define SWGID_AVPC 1
> +#define SWGID_DC 2
> +#define SWGID_DCB 3
> +#define SWGID_EPP 4
> +#define SWGID_G2 5
> +#define SWGID_HC 6
> +#define SWGID_HDA 7
> +#define SWGID_ISP 8
> +#define SWGID_ISP2 SWGID_ISP
> +/* UNUSED: 9 */
> +/* UNUSED: 10 */
> +#define SWGID_MPE 11
> +#define SWGID_MSENC SWGID_MPE
> +#define SWGID_NV 12
> +#define SWGID_NV2 13
> +#define SWGID_PPCS 14
> +#define SWGID_SATA2 15
> +#define SWGID_SATA 16
> +#define SWGID_VDE 17
> +#define SWGID_VI 18
> +#define SWGID_VIC 19
> +#define SWGID_XUSB_HOST 20
> +#define SWGID_XUSB_DEV 21
> +#define SWGID_A9AVP 22
> +#define SWGID_TSEC 23
> +#define SWGID_PPCS1 24
> +/* UNUSED: 25 */
> +/* UNUSED: 26 */
> +/* UNUSED: 27 */
> +/* UNUSED: 28 */
> +/* UNUSED: 29 */
> +/* UNUSED: 30 */
> +/* UNUSED: 31 */
> +
> +/* Reserved: 32-63 */
> +
> +#define SWGID(x)	(1ULL << SWGID_##x)

I'm not entirely sure where to find these mappings in the TRM. I see
that there's a list of the groups in 15.10.11, but where do the numbers
come from? And why are some of the names aliased? If it's for
readability only maybe we could add some more for SWGID_HC ->
SWGID_HOST1X and perhaps SWGID_NV -> SWGID_GR3D.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/3a0229ff/attachment-0001.sig>
