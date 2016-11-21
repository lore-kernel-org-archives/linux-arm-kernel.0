From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2016 09:24:45 +0000
Subject: [PATCH v2] ARM: Drop fixed 200 Hz timer requirement from Samsung
 platforms
In-Reply-To: <CA+Ln22GyRwywcxdO4Gp67d8TfpjfNzaE0z25=WW9GWibjGkDuQ@mail.gmail.com>
References: <1479453418-25314-1-git-send-email-krzk@kernel.org>
 <22757093.ejshJp9T7L@wuerfel>
 <CA+Ln22GyRwywcxdO4Gp67d8TfpjfNzaE0z25=WW9GWibjGkDuQ@mail.gmail.com>
Message-ID: <20161121092445.GA1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 03:01:57PM +0900, Tomasz Figa wrote:
> One thing to correct here is that the typical clock is PCLK, which is
> derived from one of the PLLs and AFAIR is between 33-66 MHz on
> s3c24xx. Technically you can drive the PWM block from an external
> clock (12 MHz for some board-file based boards), but for simplicity
> this functionality was omitted in the new PWM timer driver used for DT
> boards (which worked fine with the PWM driven by PCLK).

So that's a knowingly-made regression for s3c24xx then.  Pretty
disgusting developer behavior to do that, IMHO.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
