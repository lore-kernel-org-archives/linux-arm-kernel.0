From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Oct 2015 11:04:27 +0100
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <56260E56.10403@sigmadesigns.com>
References: <560EFDB3.9010305@free.fr> <11113740.WL812ZaRcZ@wuerfel>
 <5612A473.8030405@sigmadesigns.com>
 <5613EF4C.30603@sigmadesigns.com>
 <CAL_JsqJ+WTBYF=sJWbkgNzL48H5AiXL4aoVV3DNiL6T_UQKQfg@mail.gmail.com>
 <561D2952.4060908@sigmadesigns.com>
 <CAL_JsqKa4trfpLY_DPsjBrfH-7SSUQMACYVW7DNN1=Pv3B4FrA@mail.gmail.com>
 <5624CF62.6020001@sigmadesigns.com>
 <CAL_Jsq+jthx9ffnUm-G-TV9LdxBRp3SKyhyfcVu=7kN3CuumJw@mail.gmail.com>
 <56260E56.10403@sigmadesigns.com>
Message-ID: <20151020100427.GV32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 11:50:14AM +0200, Marc Gonzalez wrote:
> My problem then, is that my current firmware does not set L310_AUX_CTRL_NS_LOCKDOWN
> and does not allow updating that bit.

And if the bit isn't set, then l2c_unlock won't be called due to:

static void l2c310_unlock(void __iomem *base, unsigned num_lock)
{
        if (readl_relaxed(base + L2X0_AUX_CTRL) & L310_AUX_CTRL_NS_LOCKDOWN)
                l2c_unlock(base, num_lock);
}

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
