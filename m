From: trd@45mercystreet.com (Toby Douglass)
Date: Wed, 25 Nov 2009 01:34:21 +0100
Subject: CAS implementation may be broken
In-Reply-To: <20091124225605.GJ17481@n2100.arm.linux.org.uk>
References: <20091124013231.GB14645@shareable.org>
	<1259061596.13956.15.camel@pc1117.cambridge.arm.com>
	<4B0C5F90.7050503@45mercystreet.com>
	<20091124225605.GJ17481@n2100.arm.linux.org.uk>
Message-ID: <4B0C7B8D.3010800@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Tue, Nov 24, 2009 at 11:34:56PM +0100, Toby Douglass wrote:

>> Additionally; the DMB afterwards seemed to have no value.  You could  
>> perform the STREX and then your thread could pause indefinitely and were  
>> you in a situation where you store was not immediately visible or  
>> correctly ordered to another thread, that thread would then read the old  
>> value.

> The two DMBs are there to prevent other loads and stores on the _local_
> CPU being speculated inside the compare-and-swap operation, either by
> the compiler or the CPU.

Ahhh!

Forest, trees, etc...
