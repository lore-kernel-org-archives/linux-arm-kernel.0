From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 1 Jun 2016 20:05:20 +0800
Subject: [PATCH v3 09/12] EXAMPLE CODE: usb: port: Parse pwrseq phandle
 from Device Tree
In-Reply-To: <146477144362.1485.3331887341591876278@sboyd-linaro>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <1464768141-25420-10-git-send-email-k.kozlowski@samsung.com>
 <146477144362.1485.3331887341591876278@sboyd-linaro>
Message-ID: <20160601120520.GB16740@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 01:57:23AM -0700, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2016-06-01 01:02:18)
> > Parse usb-pwrseq property from Device Tree to get the phandle to pwrseq
> > device.  The pwrseq device will be used by USB hub to cycle the power
> > before activating ports.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Drive by review comment.
> 
> I was hoping this would help me with a problem I'm having where I have a
> hub (smsc4604) that needs to be taken out of reset before my HSIC
> controller sends a USB reset to it, but it seems this is more about
> doing some sort of power on sequence after enumeration?
> 

No, you may need to do reset before enumeration, the general purpose of
reset is eliminate unstable hardware state, and let the controller find
the device.

Try to do it at bootloader to see if it works for you.

-- 

Best Regards,
Peter Chen
