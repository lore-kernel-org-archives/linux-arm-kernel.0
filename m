From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 04 Nov 2014 17:24:42 +0000
Subject: [PATCH v3 15/19] arm/arm64: KVM: add opaque private pointer to
 MMIO accessors
In-Reply-To: <20141104154414.GN16132@cbox>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-16-git-send-email-andre.przywara@arm.com>
 <20141104154414.GN16132@cbox>
Message-ID: <54590BDA.3050609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/11/14 15:44, Christoffer Dall wrote:
> On Fri, Oct 31, 2014 at 05:26:50PM +0000, Andre Przywara wrote:
>> For a GICv2 there is always only one (v)CPU involved: the one that
>> does the access. On a GICv3 the access to a CPU redistributor is
>> memory-mapped, but not banked, so the (v)CPU affected is determined by
>> looking at the MMIO address region being accessed.
>> To allow passing the affected CPU into the accessors, extend them to
>> take an opaque private pointer parameter.
>> For the current GICv2 emulation we ignore it and simply pass NULL
>> on the call.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Why does it have to be an opaque private pointer?  Would it not always
> be a struct vcpu * or a vcpu_id then?

IIRC Marc suggested this once be more future proof. Also a pointer makes
it easier to pass NULL in the GICv2 parts of the code, which makes it
more obvious that this value is not used in this case.

Marc, did I miss some more rationale?
Does that still hold?

Cheers,
Andre.
