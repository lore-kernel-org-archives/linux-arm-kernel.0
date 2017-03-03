From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 3 Mar 2017 18:26:28 +0100
Subject: No output on console despite ignore_loglevel earlyprintk
In-Reply-To: <20170303165548.GO21222@n2100.armlinux.org.uk>
References: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
 <20170303165548.GO21222@n2100.armlinux.org.uk>
Message-ID: <3293964b-aec2-e8b8-46f5-49b0eacc4718@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 03.03.2017 um 17:55 schrieb Russell King - ARM Linux:
> On Fri, Mar 03, 2017 at 05:42:02PM +0100, Marc Gonzalez wrote:
>> I'm confused about early consoles and earlyprintk, and all that good stuff.
>> When my kernel panics, I don't get the expected output.
>>
>> Using "mem=256M ignore_loglevel earlyprintk"
>>
[...]
>> [    0.014325] Console: colour dummy device 80x30
>> [    0.018885] console [tty0] enabled
>> [    0.022396] bootconsole [earlycon0] disabled
>>
>> And it hangs there.
> 
> tty0 is the kernel virtual terminal console, which is what appears on
> VGA or framebuffers.  This is the default console if nothing else is
> specified.
> 
> What happened here is that the virtual terminal console registered, was
> detected to be the system console, so early console was shut down, and
> the boot messages logged to the virtual terminal console instead.

Why does passing console= make a difference though?

I expect stdout-path to have the same effect as the command line, and I
am pretty sure that that was previous behavior in, e.g., v4.4.

Note that I am using earlycon, as opposed to earlyprintk above.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
