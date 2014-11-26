From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Nov 2014 17:51:39 +0100
Subject: [RFC PATCH v2 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <54753AED.3050909@huawei.com>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <2966212.dpWQ0OTb0A@wuerfel> <54753AED.3050909@huawei.com>
Message-ID: <2133591.n7Y4zNvRib@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014 10:29:01 Shannon Zhao wrote:
> On 2014/11/25 19:02, Arnd Bergmann wrote:
> > No, don't hardcode ARM specifics into a common binding either. I've looked
> > at the ibm,associativity properties again, and I think we should just use
> > those, they can cover all cases and are completely independent of the
> > architecture. We should probably discuss about the property name though,
> > as using the "ibm," prefix might not be the best idea.
> > 
> 
> Yeah, I have read the relevant codes in qemu. I think the "ibm,associativity" is more scalable:-)

Ok

> About the prefix, my opinion is that as this is relevant with NUMA,
> maybe we can use "numa" as the prefix.

A prefix should really be the name of a company or institution, so it could
be "arm" or "linux", but not "numa". Would could use "numa-associativity"
with a dash instead of a comma, but that would still be somewhat imprecise
because the associativity property is about system topology inside of
a NUMA domain as well, such as cores, core clusters or SMT threads that
only share caches but not physical memory addresses.

	Arnd
