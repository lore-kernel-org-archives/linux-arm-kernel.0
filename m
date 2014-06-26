From: Mattis.Lorentzon@autoliv.com (Mattis Lorentzon)
Date: Thu, 26 Jun 2014 14:44:52 +0000
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <20140626140115.GQ32514@n2100.arm.linux.org.uk>
References: <C4A61A5CA4AD2246942F4BA6F20ACB804356534D@ALVA-EXMB04.alv.autoliv.int>
 <20140626140115.GQ32514@n2100.arm.linux.org.uk>
Message-ID: <C4A61A5CA4AD2246942F4BA6F20ACB80435655E9@ALVA-EXMB04.alv.autoliv.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for your reply,

> On Wed, Jun 25, 2014 at 01:55:05PM +0000, Mattis Lorentzon wrote:
> > I have a similar issue with v3.16-rc2 as previously reported by Waldemar
> Brodkorb for v3.15-rc4.
> > https://lkml.org/lkml/2014/5/9/330
> 
> This URL returns no useful information.  I find that lkml.org is broken more
> times than not in recent years.  Please use a different archive site when
> referring to posts, thanks.

http://lkml.iu.edu/hypermail/linux/kernel/1405.1/01114.html

> I have had two iMX6 platforms running root-NFS for about the last six to nine
> months with various workloads, and have never seen this oops.
> Unfortunately, the description above gives very little information for what
> the mechanism to trigger this bug may be.  For example, if I wanted to
> reproduce it, what would I need to do?

We have managed to trigger the Oops by just transferring a large file over nfs
cat /mnt/foo > /dev/null
where foo is a file that is approximately 2 GB. There may be some packet losses
on this network, perhaps this differs from your workload?

> > The error is sporadic and it seems to occur more frequently when using
> perf.
> 
> So it occurs when not using perf?

Yes, certainly, see above.

We have done some more investigations, please find it in this mail:

http://lkml.iu.edu/hypermail/linux/kernel/1406.3/02190.html

The Oops seems to have been introduced somewhere between v3.12 and v3.13:

- The Oops is reproducible within seconds when running Linux 3.16-rc2.
- We have observed the Oops on 8 different hardware units and two different chipsets (Freescale i.MX6 and Xilinx Zynq).
- The Oops has not been seen on Linux 3.12 so it appears to be good.
- The Oops has been seen on Linux 3.13, 3.14, 3.15, 3.16-rc2 so these appear to be bad.

Configs and a couple of Oops reports are attached to the linked mail.

Best regards,
Mattis Lorentzon
***************************************************************
Consider the environment before printing this message.

To read Autoliv's Information and Confidentiality Notice, follow this link:
http://www.autoliv.com/disclaimer.html
***************************************************************
