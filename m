From: will.deacon@arm.com (Will Deacon)
Date: Mon, 6 Oct 2014 11:22:21 +0100
Subject: [PATCHv2 0/5] Legacy instruction emulation for arm64
In-Reply-To: <1412170630-18408-1-git-send-email-punit.agrawal@arm.com>
References: <1412165279-8709-1-git-send-email-punit.agrawal@arm.com>
 <1412170630-18408-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <20141006102221.GC12935@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 02:37:05PM +0100, Punit Agrawal wrote:
> [ Correcting Arnd's email. Apologies for the extra copy ]
> 
> Hi,

Hi Punit,

> This is the second posting of the legacy instruction support for
> arm64. The previous posting can be found at [1].
> 
> The patchset ports the infrastructure to register hooks for undefined
> instruction abort and uses this to adds support for the emulation of
> SWP{B} and CP15 Barrier instructions from ARMv7 to the v8 port of
> Linux.
> 
> Via sysctl, it is possible to control the runtime state of emulation
> * Off
>   sysctl value: 0
>   Generates undefined instruction abort. Default for instructions that
>   have been obsoleted in the architecture, e.g., SWP
> 
> * Emulate
>   sysctl value: 1
>   Uses software emulation. To aid migration of software, in this mode
>   usage of emulated instruction is traced as well as rate limited
>   warnings are issued. This is the default for deprecated
>   instructions, .e.g., CP15 barriers
> 
> * Enable
>   sysctl value: 2
>   Although marked as deprecated, some implementations may support the
>   enabling/disabling of hardware support for the execution of these
>   instructions. Using hardware execution generally provides better
>   performance, but at the loss of ability to gather runtime statistics
>   about the use of the deprecated instructions.

This needs to be documented in Documentation/arm64/ so that people can
easily understand how to control the emulations that we have, what they
default to and why that is the case.

Will
