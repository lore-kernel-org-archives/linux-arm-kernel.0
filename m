From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Thu, 9 Jun 2016 22:11:56 +0900
Subject: v4.7-rc2 kernel fails to boot when acpi=force
In-Reply-To: <20160608094733.GA14506@leverpostej>
References: <125b057c-647b-9db7-11b4-4b7123e4b80a@riken.jp>
 <20160607102317.GC2633@leverpostej>
 <7faf36bf-00d9-fb37-381a-6324d1dba977@riken.jp>
 <20160607110540.GD2633@leverpostej>
 <70463161-1d59-a7ad-09c4-c4c7dd68d1ab@riken.jp>
 <20160608094733.GA14506@leverpostej>
Message-ID: <c6fb49ed-680a-b964-ed27-bc45e30e67f8@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Applying relevant series from Aleksey and Leif in the leg-kernel tree on 
top of v4.7-rc2 works. (commits 1512e71bdcf and 3df2702192e42)

Many thanks to Graeme for catching up the development.

On 6/8/16 6:47 PM, Mark Rutland wrote:
>
> It looks like the we're failing to find the console (judging by the fact
> the kernel opted to use a dummy device). The other messages look largely
> fine. It may be worth also passing "keep_bootcon" to try to get a few
> more lines of messages, though that may or may not be helpful.
>
> I was under the impression that SPCR told us the console to use, but
> from grepping the kernel source code, it looks like mainline doesn't
> support that yet. Given that, I'm at a loss as to how this could have
> worked for v4.6.
>
> I take it you've used the exactly same command line for v4.6 and
> v4.7-rc2? i.e. you weren't previously passing something like
> "console=ttyAMA0,115200"?
>
> Were you using a vanilla v4.6? Or some distro derivative?
>
> Thanks,
> Mark.
>
