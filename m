From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 May 2015 18:01:14 +0100
Subject: [PATCH v4 10/12] KVM: arm64: guest debug, HW assisted debug
 support
In-Reply-To: <87y4kpke91.fsf@linaro.org>
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
 <1431700035-23479-11-git-send-email-alex.bennee@linaro.org>
 <20150515152346.GB23652@leverpostej> <87y4kpke91.fsf@linaro.org>
Message-ID: <20150515170114.GD23652@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > This gets more fun when you consider the context-aware breakpoints are
> > the highest numbered. So the set of (context-aware) breakpoints might
> > not intersect across all CPUs.
> 
> I didn't see a reference to that in the ARM ARM. It seemed to imply any
> breakpoint could be context aware is .BT was appropriately set and
> linked to the VR.  

The existence of ID_AA64_DFR0_EL1.CTX_CMPs implies otherwise, though I
haven't dug much deeper.

Thanks,
Mark.
