From: narkewoody@gmail.com (woody)
Date: Wed, 14 Nov 2012 22:23:55 +0800
Subject: Kernel uncompression error
Message-ID: <k809hq$1q3$1@ger.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, List

I just built a 3.2.x ARM kernel and tried to have it boot by a boot 
loader (vivi) on my s3c2410a ARM board.  The kernel was built with 
default configuration s3c2410.

... But, the following error printed on the console:

---------------------
Uncompressing Linux...

uncompression error

-- System halted
---------------------

What kinds of reasons can most possibly lead the error?  I searched on 
the net and found some answers, but I cannot well judge them:

1. There is a D-Cache patch should be applied, but the message was 
talking about 2.4.x kernel, so I guess if there really was a bug around 
here, it should already been fixed. Right?

2. Probably the kernel image (here is a zImage) is too big, then the 
uncompressed code was overwriting the original compressed part of the 
image.  This sounds a little relevant.  My boot loader was loading the 
kernel image to ram address 0x300008000, and my zImage is about 1.9M. 
Do you think this is the reason?

Thanks in advance!



-- 
woody
I can't go back to yesterday - because I was a different person then.
