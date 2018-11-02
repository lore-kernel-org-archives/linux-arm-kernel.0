From: jcm@redhat.com (Jon Masters)
Date: Fri, 2 Nov 2018 02:02:03 -0400
Subject: [PATCH v5 11/17] arm64: docs: document pointer authentication
In-Reply-To: <20181019174524.GC4429@brain-police>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-12-kristina.martsenko@arm.com>
 <9acb0cd2-66b0-1c41-b1a8-7c70608e9a9b@foss.arm.com>
 <7b0de19b-45b9-f4df-25d1-c7e80fab49dc@arm.com>
 <20181019113556.ljbdmjo5pdw7muvz@mbp>
 <e73035eb-2157-7a9c-3631-d4d2ad0b7d38@arm.com>
 <20181019151029.GD3985@arrakis.emea.arm.com>
 <20181019174524.GC4429@brain-police>
Message-ID: <d73e8824-bb8e-8172-4541-9be136453020@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/18 1:45 PM, Will Deacon wrote:

>>> I think an alternative solution is to just disable trapping of pointer
>>> auth instructions in KVM. This will mean that the instructions will
>>> behave the same in the guest as they do in the host. HINT-space
>>> instructions (including XPACLRI) will behave as NOPs (or perform their
>>> function, if enabled by the guest), and will not trap.
>>
>> OK, so this means disabling the trap (during early EL2 setup) but still
>> sanitizing the CPUID not to report the feature to EL1 unless fully
>> supported on all CPUs.
> 
> ... which is perfectly sensible, but not actually my main concern here.
> I'm worried about the possibility of distributions shipping *now* with
> userspace that's built with these instructions. That stuff is going to
> break if/when it encounters v8.3 hardware, and I don't think we can do
> much about it other than alert them to the potential issue.

FYI tracking this for RHEL. It's not a problem currently. I'll alert our
tools teams to hold off on any PAC work until this is figured out.

Jon.

-- 
Computer Architect | Sent with my Fedora powered laptop
