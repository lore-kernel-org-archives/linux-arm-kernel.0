From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jan 2014 17:17:55 +0000
Subject: [PATCH V2 4/6] ARM: Make PID_IN_CONTEXTIDR incompatible with
 PID_NS
In-Reply-To: <CANsc=4UgWrFis6hi-0mXZAfery7YGDJ2F+NdZBzq6afwx_i58A@mail.gmail.com>
References: <1390581656-16372-1-git-send-email-adrienverge@gmail.com>
 <1390581656-16372-5-git-send-email-adrienverge@gmail.com>
 <20140124164343.GJ31040@mudshark.cambridge.arm.com>
 <CANsc=4UgWrFis6hi-0mXZAfery7YGDJ2F+NdZBzq6afwx_i58A@mail.gmail.com>
Message-ID: <20140124171754.GM31040@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 24, 2014 at 05:16:28PM +0000, Adrien Verg? wrote:
> 2014/1/24 Will Deacon <will.deacon@arm.com>:
> > Are you sure about this? The value we write is actually task_pid_nr, which I
> > believe to be globally unique.
> 
> You are right: the task_pid_nr is unique in the system. However when
> using namespaces, the so called "PID" is the virtual number that
> processes in different namespaces can share.
> 
> This PID is the one visible by user-space tasks, in particular
> user-space tracers and debuggers. These programs would expect to find
> the PID of the traced process in the Context ID reg, while it is not.
> I think it is better to remove confusion by making PID_IN_CONTEXTIDR
> and PID_NS incompatible.
> 
> What do you think?

I think I'd rather have the global ID than disable a potentially useful
feature, especially since this is likely to be consumed by external trace
tools as opposed to user-space tasks.

Will
