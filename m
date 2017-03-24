From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 24 Mar 2017 10:53:48 -0700
Subject: [PATCH 3/9] arm64: mm: install SError abort handler
In-Reply-To: <20170324173515.GB10746@leverpostej>
References: <20170324144632.5896-1-opendmb@gmail.com>
 <20170324144632.5896-4-opendmb@gmail.com>
 <20170324151654.GD29588@leverpostej> <58D54DE8.9020707@gmail.com>
 <20170324173515.GB10746@leverpostej>
Message-ID: <710c4142-ae20-9715-3e51-910a2073a64e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2017 10:35 AM, Mark Rutland wrote:
> On Fri, Mar 24, 2017 at 09:48:40AM -0700, Doug Berger wrote:
>> On 03/24/2017 08:16 AM, Mark Rutland wrote:
>>> On Fri, Mar 24, 2017 at 07:46:26AM -0700, Doug Berger wrote:
> 
>> If you would consider an alternative implementation where we scrap
>> the SError handler (i.e. maintain the ugliness in our downstream
>> kernel) in favor of a more gentle user mode crash on SError that
>> allows the kernel the opportunity to service the interrupt for
>> diagnostic purposes I could try to repackage that.
> 
> If this is just for diagnostic purposes, I believe you can register a
> panic notifier, which can then read from the bus. The panic will occur,
> but you'll have the opportunity to log some information to dmesg.

And crash the kernel? That sounds awful, FWIW the ARM/Linux kernel is
able to recover just fine from user-space accessing e.g: invalid
physical addresses in the GISB register space, bringing the same level
of functionality to ARM64/Linux sounds reasonable to me.
-- 
Florian
