From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Oct 2015 19:27:43 +0200
Subject: [PATCH v2] ARM: dts: sun7i: Correct USB regulators on pcDuino v3
 Nano
In-Reply-To: <1444481572-13617-1-git-send-email-ats@offog.org>
References: <1444481572-13617-1-git-send-email-ats@offog.org>
Message-ID: <20151011172743.GW2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2015 at 01:52:52PM +0100, Adam Sampson wrote:
> The LinkSprite pcDuino v3 Nano's two USB host ports are powered by a
> single RT9701GB regulator, which has its enable input tied to the A20's
> PD2 pin, pulled up to 3v3 via a 10k resistor.
> 
> However, the script.bin that shipped with the device listed PH11 and PH3
> as Vbus control pins for the two USB ports. Neither of these are
> actually connected to anything.
> 
> Siarhei Siamashka spotted this problem while reviewing the other
> LinkSprite boards. This patch fixes it by only defining a single
> regulator, controlled by PD2. Testing shows that the USB ports are now
> (correctly) only powered up once the USB PHY driver is loaded.
> 
> Reported-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
> Signed-off-by: Adam Sampson <ats@offog.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151011/298206df/attachment.sig>
