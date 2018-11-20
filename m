From: pasha.tatashin@soleen.com (Pavel Tatashin)
Date: Tue, 20 Nov 2018 15:03:27 +0000
Subject: [PATCH v1 1/1] arm64: Early boot time stamps
In-Reply-To: <01ae5979-9bcd-dd59-adda-efbf69f388ca@arm.com>
References: <20181119214443.25175-1-pasha.tatashin@soleen.com>
 <20181119214443.25175-2-pasha.tatashin@soleen.com>
 <d66a60d9-6772-a951-9da4-c07443b48aad@arm.com>
 <CA+CK2bAKcdZRRMwhcQ0QnBJ3_6bg=zhaeM7v74f+QFwkw9h17A@mail.gmail.com>
 <01ae5979-9bcd-dd59-adda-efbf69f388ca@arm.com>
Message-ID: <20181120150327.kc5bbkfecmfwbgzn@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-11-20 14:55:23, Marc Zyngier wrote:
> > Yeah, I saw 56 is used in arm_arch_timer.c, but I could not find where
> > this minimum is defined in aarch64 specs. I will change it to 56.
> 
> See D10.1.2 (The system counter) in the ARM ARM[1], which says:
> 
> <quote>
> The Generic Timer provides a system counter with the following
> specification:
> Width	At least 56 bits wide.
> 	The value returned by any 64-bit read of the counter is
> 	zero-extended to 64 bits.
> </quote>
> 
> This is not AArch64-specific though, and 32bit systems implementing the
> generic timers have the exact same requirements.

Thank you, makes sense. I was thinking there could be AArch64 specific
minimum limit.

> 
> > I will send v2 soon.
> 
> Please wait a bit and give others a chance to review this too.

I already sent, but will wait in the future before sending v3.

> 
> Thanks,
> 
> 	M.
> 
> [1] https://static.docs.arm.com/ddi0487/da/DDI0487D_a_armv8_arm.pdf
> -- 
> Jazz is not dead. It just smells funny...
