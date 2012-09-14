From: schen@mvista.com (Steve Chen)
Date: Fri, 14 Sep 2012 13:39:15 -0500
Subject: Kernel fails to boot with "crc error -- System halted"
In-Reply-To: <1347638108.3789.YahooMailNeo@web133202.mail.ir2.yahoo.com>
References: <1347638108.3789.YahooMailNeo@web133202.mail.ir2.yahoo.com>
Message-ID: <CAHKQLBEs0N5NBqmkSMALRx3ioV4g8JR1RY=g644R-wTU6YcNXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 10:55 AM, Ellis Andrew <ajellisuk@yahoo.co.uk>wrote:

> Hi
>
> I have run into a major problem in that when I program my kernel into
> flash on my system or try and run it from RAM I get the following output:
>
> *## Booting image at 00060000 ...
> ## Copy image from flash 00060000 to ram 00200000 ...
> Image Name:
> Image Type: ARM Linux Kernel Image (uncompressed)
> Data Size: 1871640 Bytes = 1.8 MB
> Load Address: 00008000
> Entry Point: 00008000
> Verifying Checksum ... OK
> OK
>
> Starting kernel ...
>
> Uncompressing Linux.............................................
> .................................................. ....................
>
> crc error
>
> -- System halted
> *
>
> The checksum passes, but the image type is uncompressed, so why is the
> kernel trying to decompress?
>
> From a successful build I had the same message about uncompressing the
> kernel, so I don't understand what the problem is. I have previously been
> able to build and run kernels without the above problem. I cannot work out
> what I have done to cause this problem, could someone please enlighten me
> as to what could be going wrong?
>
> Kind regards
>
>
I saw the same problem a few years ago.  The problem was traced to hardware
data cache issue.  I would suggest test the RAM to make sure it functions
properly, and perhaps disable data cache (typically chip maker fix this
type of issues before the final release, so it is unlikely to help).

Steve
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120914/eff51c1c/attachment-0001.html>
