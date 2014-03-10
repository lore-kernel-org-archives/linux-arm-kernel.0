From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 10 Mar 2014 08:16:44 -0300
Subject: [PATCH 1/9] usb: chipidea: usbmisc: Add USB Host support for
 i.MX25/i.MX35 CPUs
In-Reply-To: <1394427482.225153574@f354.i.mail.ru>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
 <CAOMZO5DPK41DqNT7b_eV2owqPvAsqHZ7zgkqDVSmPUx2Bv2TVA@mail.gmail.com>
 <1394427482.225153574@f354.i.mail.ru>
Message-ID: <CAOMZO5BJafTT8bOftmdRRCAdUJJLh_pzR9wEdtp8TGQYRZ0KMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Mon, Mar 10, 2014 at 1:58 AM, Alexander Shiyan <shc_work@mail.ru> wrote:

> Fabio, start with to make work USB port on your board in the bootloader.
> Then with the previous driver (ehci-mxc).
> Most likely problem is a wrong (or missing) clock.
> As I mentioned earlier, DTS has incorrect clock nodes.

Yes, you are right, thanks.

If I change the usb host clocks as:

-                               clocks = <&clks 9>, <&clks 70>, <&clks 8>;
-                               clock-names = "ipg", "ahb", "per";
+                               clocks = <&clks 70>;

Then USB host1 works fine on my mx25pdk board.

Denis,

Could you please resend 4/9 by changing the clocks nodes in the OTG
and Host1 ports as shown above?

Thanks,

Fabio Estevam
