From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 16 Sep 2015 09:15:24 +0200
Subject: NFS/TCP/IPv6 acting strangely in 4.2
In-Reply-To: <1442386435.3756.282.camel@vitec.com> ("Damien =?utf-8?Q?Th?=
 =?utf-8?Q?=C3=A9bault=22's?=
 message of "Wed, 16 Sep 2015 06:53:57 +0000")
References: <20150911113839.GO21084@n2100.arm.linux.org.uk>
 <1442386435.3756.282.camel@vitec.com>
Message-ID: <87zj0mbzsj.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Damien,
 
 On mer., sept. 16 2015, Damien Th?bault <damien.thebault@vitec.com> wrote:

> On Fri, 2015-09-11 at 12:38 +0100, Russell King - ARM Linux wrote:
>> I have a recent Marvell Armada 388 board here which uses the mvneta
>> driver.  I'm seeing some weird effects with NFS with it acting as a
>> client.
>
> Hello,
>
> I'm upgrading a Marvelle Armada 370 board using the mvneta driver from
> 4.0 to 4.2 and noticed issues with NFS booting.
> Basically, most of the time init returns with an error code, or
> programs segfault or throw illegal instructions.
>
> Since it worked fine on 4.0 I bisected until I found commit
> a84e32894191cfcbffa54180d78d7d4654d56c20 "net: mvneta: fix refilling
> for Rx DMA buffers".
>
> If I revert this commit, everything seems to get back to normal.
> Could you try it ? The two issues look very similar.

Actually there was a bug with this commit, but a fix had been submitted
and accepted yesterday, you can find him here:
https://patchwork.ozlabs.org/patch/518111/.

Thanks,

Gregory

>
> Regards

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
