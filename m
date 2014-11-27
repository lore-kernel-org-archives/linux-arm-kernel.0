From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 27 Nov 2014 21:53:12 +0000
Subject: Code generation involving __raw_readl and __raw_writel
In-Reply-To: <54779718.1010001@free.fr> (Mason's message of "Thu, 27 Nov 2014
 22:26:48 +0100")
References: <5476FFA2.8010403@free.fr> <5477496F.7040807@free.fr>
 <yw1x1toofwhf.fsf@unicorn.mansr.com> <5308846.uKgsdBdD5V@wuerfel>
 <54779718.1010001@free.fr>
Message-ID: <yw1xwq6ge2ev.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <mpeg.blue@free.fr> writes:

> On 27/11/2014 17:51, Arnd Bergmann wrote:
>
>> On Thursday 27 November 2014 16:18:20 M?ns Rullg?rd wrote:
>>
>>> That's great.  You mentioned working against 3.14.  Do you have any
>>> plans to move onto the current version?  That would be a prerequisite
>>> for upstream acceptance.
>> 
>> FWIW, it's also a good strategy to do the initial bringup on the latest
>> kernel and then backport to the older one for product work, otherwise
>> you end up doing the forward port twice, and it's almost always harder
>> than a backport.
>
> Hmmm, I was told to target 3.14, because that's what we plan to support.
>
> Maybe I can push one driver at a time?

Normally you would start with minimal chip support, just enough to
configure memory and a uart, then add drivers for various devices one by
one.

New ARM systems are expected to use DT, so you should also be switching
to that if you haven't already.

-- 
M?ns Rullg?rd
mans at mansr.com
