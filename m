From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 30 Mar 2012 09:33:30 +0800
Subject: How to add GPIO outputs to the PXA2xx MFP configuration?
In-Reply-To: <1332958336.11131.YahooMailClassic@web29001.mail.ird.yahoo.com>
References: <1332958336.11131.YahooMailClassic@web29001.mail.ird.yahoo.com>
Message-ID: <CAN1soZwzBqDGTX+a-maVr5baaoZ7qwgdvXyPeya5R80cN_iA0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 2:12 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
> On PXA2xx platforms, the MFP API (described in Documentation/arm/pxa/mfp.txt)
> provides values for the following:
>
> 1. GPIO inputs (e.g. GPIO105_GPIO).
> 2. Alternate function inputs (e.g. GPIO105_CIF_DD_1).
> 3. Alternate function outputs (e.g. GPIO105_KP_MKOUT_2).
>
> It does not provide values for GPIO outputs (i.e. AF0 outputs).
>
> One cannot use the macro used by the MFP API internally - MFP_CFG_OUT() - to
> define new GPIO output values, since that macro is forbidden in platform code.
>
> Without the ability to add GPIO outputs to the MFP configuration, it is not
> possible to drive GPIO outputs high during sleep mode.
>
> This would be useful, for example, on the hx4700 platform, where driving the
> infrared powerdown GPIO 105 high during sleep mode would save some mA.
>
> So my question is: what method should one use to add GPIO outputs to the MFP
> configuration?
>
> One possible method, namely manually defining values in the platform code:
>
> ? ? ? ?MFP_PIN_GPIO105 | MFP_AF0 | MFP_DIR_OUT | MFP_LPM_DRIVE_HIGH,
>
> is essentially no different from using the forbidden MFP_CFG_OUT() macro.
>

Does MFP_CFG_OUT() help you? This macro is defined in mfp-pxa2xx.h.
