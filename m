From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Mon, 9 Jan 2017 00:16:00 +0000
Subject: [linux-sunxi] [PATCH 1/2] drivers: pinctrl: add driver for
 Allwinner H5 SoC
In-Reply-To: <20170105224210.wfinfucbpkkd44om@lukather>
References: <20161223125001.1176-1-icenowy@aosc.xyz>
 <1280f095-ab03-93f8-14d2-99d13ba1ce55@arm.com>
 <CACRpkdYQhfid3VRcaj=7as_+Zg=pX3Svp9FJ_W_Ft8nVuoZqKQ@mail.gmail.com>
 <20170105224210.wfinfucbpkkd44om@lukather>
Message-ID: <38fe3491-457a-f0c5-54fb-9defdcd45045@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/17 22:42, Maxime Ripard wrote:
> On Fri, Dec 30, 2016 at 01:55:44PM +0100, Linus Walleij wrote:
>> On Mon, Dec 26, 2016 at 3:33 PM, Andr? Przywara <andre.przywara@arm.com> wrote:
>>
>>> So while this patch technically looks correct, I was wondering if we
>>> should really explore the possibility of making the whole of sunxi
>>> pinctrl DT controlled.
>>> I brought this up a while ago, but people weren't overly enthusiastic
>>> about it, though their argument weren't really convincing to me[1].
>>>
>>> So:
>>> As this "driver" here is basically a table linking GPIO bit settings
>>> (the actual mux value) to names and every pin we care about needs to be
>>> enumerated in the DT anyway, why not just add something like:
>>> allwinner,pinmux = <4>;
>>> to each pin(group) in the DT and get rid of this "driver" file here
>>> entirely?
>>
>> I'm open to that if you can use pinctrl-single which is in the kernel
>> for this purpose only, and is used with both OMAPs and HiSilicon.
> 
> I'm not open to that, and I'm getting tired of discussing it over and
> over again. Andre, if you want to be convinced again, please read the
> last discussion we had on this topic.

As I said: It didn't convince me back then. And frankly we didn't really
discuss it back then, I just refrained from entering a discussion
against _two_ maintainers at this time, since my capacity on this kind
of email threads is really very limited - especially for something that
is a hobby to me.

It isn't the highest priority on my list, but I am still planning on
sketching something, so that we can discuss about actual code.
As it seems like your new patches bring some relief to the immediate
copy&paste pain (though the actual DT aspect still remains), I will shut
up - for now ;-)

Cheers,
Andre.
