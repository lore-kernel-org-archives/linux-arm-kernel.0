From: blogic@openwrt.org (John Crispin)
Date: Mon, 25 Jan 2016 14:46:06 +0100
Subject: [PATCH V2 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <CABxcv==AzZju5a3Na0OQf6PmsM_J8auPLzxffLsZ09at8DWXew@mail.gmail.com>
References: <1453718405-40815-1-git-send-email-blogic@openwrt.org>
 <1453718405-40815-2-git-send-email-blogic@openwrt.org>
 <CABxcv=kWnUwpCo=JJbnPAARRM226YfBJw_6yF7MiE8-7iqBD+Q@mail.gmail.com>
 <56A612E2.1010509@openwrt.org> <20160125123538.GO6588@sirena.org.uk>
 <56A61F78.6070703@openwrt.org>
 <CABxcv=m32FLmLzuGC-KFmZ5q-8TmC1FrhdOw+WB-d_L53gg_tg@mail.gmail.com>
 <CABxcv==AzZju5a3Na0OQf6PmsM_J8auPLzxffLsZ09at8DWXew@mail.gmail.com>
Message-ID: <56A6271E.8060607@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/01/2016 14:25, Javier Martinez Canillas wrote:
> On Mon, Jan 25, 2016 at 10:19 AM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
> 
> [snip]
> 
>>
>> In fact, the kernel is currently not matching the compatible, it is
>> only matching because you provided a .of_compatible is provided in the
>> mfd_cell.
>>
> 
> Sorry my English was a bit off in this paragraph...
> 
> I tried to say that OF does not traverse MFD sub-devices and lookups a
> device driver that matches the compatible automatically since a MFD
> device is not a bus. Currently it is only trying to match a compatible
> string because the mfd_cell has a .of_compatible set so an of_node is
> assigned on mfd_add_device().
> 
> But it is failing to match because no OF device table is provided and
> the platform bus match callback is falling back to the driver .name to
> match so the compatible is not really used as Mark said.
> 
> Best regards,
> Javier
> 

Hi,

just so i am sure to have understood properly. i just need to drop the
compatible string from [1/2] and resend. if this is the case i will fix
the mt6397 binding doc while at it.

	John
