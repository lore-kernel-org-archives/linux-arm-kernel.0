From: cooloney@gmail.com (Bryan Wu)
Date: Tue, 13 Jan 2015 12:24:52 -0800
Subject: [PATCH] leds: netxbig: fix oops at probe time
In-Reply-To: <20150113201602.GI14570@lunn.ch>
References: <1417534330-13154-1-git-send-email-simon.guinot@sequanux.org>
 <20141211090400.GB18449@kw.sim.vm.gnt>
 <CAK5ve-KVSXS3PgafAJjstiYqezpG83p-NChS6Rt=mNMdgsB3GQ@mail.gmail.com>
 <20150113201602.GI14570@lunn.ch>
Message-ID: <CAK5ve-J+wBf08_2-XBiK2qaJ3Uy9ATZG-hZQSs7bHKUFfcnTFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 12:16 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Jan 13, 2015 at 12:14:08PM -0800, Bryan Wu wrote:
>> On Thu, Dec 11, 2014 at 1:04 AM, Simon Guinot <simon.guinot@sequanux.org> wrote:
>> > On Tue, Dec 02, 2014 at 04:32:10PM +0100, Simon Guinot wrote:
>> >> This patch fixes a NULL pointer dereference on led_dat->mode_val. Due to
>> >> this bug, a kernel oops can be observed at probe time on the LaCie 2Big
>> >> and 5Big v2 boards:
>> >>
>> >> Unable to handle kernel NULL pointer dereference at virtual address 00000008
>> >> [...]
>> >> [<c03f244c>] (netxbig_led_probe) from [<c02c8c6c>] (platform_drv_probe+0x4c/0x9c)
>> >> [<c02c8c6c>] (platform_drv_probe) from [<c02c72d0>] (driver_probe_device+0x98/0x25c)
>> >> [<c02c72d0>] (driver_probe_device) from [<c02c7520>] (__driver_attach+0x8c/0x90)
>> >> [<c02c7520>] (__driver_attach) from [<c02c5c24>] (bus_for_each_dev+0x68/0x94)
>> >> [<c02c5c24>] (bus_for_each_dev) from [<c02c6408>] (bus_add_driver+0x124/0x1dc)
>> >> [<c02c6408>] (bus_add_driver) from [<c02c7ac0>] (driver_register+0x78/0xf8)
>> >> [<c02c7ac0>] (driver_register) from [<c000888c>] (do_one_initcall+0x80/0x1cc)
>> >> [<c000888c>] (do_one_initcall) from [<c0733618>] (kernel_init_freeable+0xe4/0x1b4)
>> >> [<c0733618>] (kernel_init_freeable) from [<c058db9c>] (kernel_init+0xc/0xec)
>> >> [<c058db9c>] (kernel_init) from [<c0009850>] (ret_from_fork+0x14/0x24)
>> >> [...]
>> >>
>> >> This bug was introduced by commit 588a6a99286ae30afb1339d8bc2163517b1b7dd1
>> >> ("leds: netxbig: fix attribute-creation race").
>> >>
>> >> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
>> >> Cc: <stable@vger.kernel.org> # 3.17+
>> >> ---
>> >>  drivers/leds/leds-netxbig.c | 12 ++++++------
>> >>  1 file changed, 6 insertions(+), 6 deletions(-)
>> >
>> > Hi Bryan,
>> >
>> > Please apply up this patch.
>> >
>> > Thanks.
>> >
>> > Simon
>>
>> Sorry for the delay. I will merge it.
>
> Hi Bryan
>
> It has already been sent to arm-soc. If you are going to merge it,
> please ask Olof to drop it.
>
>        Andrew

Olof, could you please drop this from your arm-soc tree. I've merged
it to my tree. and will send a fix for Linus soon

Thanks,
-Bryan
