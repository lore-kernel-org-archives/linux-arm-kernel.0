From: stewart@linux.vnet.ibm.com (Stewart Smith)
Date: Wed, 13 Jul 2016 18:23:34 +1000
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <5352106.oQ0Ff9gWJA@wuerfel>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712145010.GA8447@leverpostej>
 <20160713023614.GB3222@dhcp-128-65.nay.redhat.com>
 <5352106.oQ0Ff9gWJA@wuerfel>
Message-ID: <87k2gqndyx.fsf@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:
> On Wednesday, July 13, 2016 10:36:14 AM CEST Dave Young wrote:
>> On 07/12/16 at 03:50pm, Mark Rutland wrote:
>> > On Tue, Jul 12, 2016 at 04:24:10PM +0200, Arnd Bergmann wrote:
>> > > On Tuesday, July 12, 2016 10:18:11 AM CEST Vivek Goyal wrote:
>> > 
>> > /proc/devicetree (aka /sys/firmware/devicetree) is a filesystem derived
>> > from the raw DTB (which is exposed at /sys/firmware/fdt).
>> > 
>> > The blob that was handed to the kernel at boot time is exposed at
>> > /sys/firmware/fdt.
>> 
>> I believe the blob can be read and passed to kexec kernel in kernel code without
>> the extra fd.
>> 
>> But consider we can kexec to a different kernel and a different initrd so there
>> will be use cases to pass a total different dtb as well. From my understanding
>> it is reasonable but yes I think we should think carefully about the design.
>
> Ok, I can see four interesting use cases here:
>
> - Using the dtb that the kernel has saved at boot time. Ideally this should not
>   require an additional step of signing it, since the running kernel already
>   trusts it.

- using current view of the hardware, flattened into a new dtb.
  This should already be trusted, as it's what we're running now (boot +
  runtime changes)

-- 
Stewart Smith
OPAL Architect, IBM.
