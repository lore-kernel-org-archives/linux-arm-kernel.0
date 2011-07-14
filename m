From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Jul 2011 11:02:54 +0100
Subject: [PATCH 1/1 V2] Add Thread Support for the Context ID Register
	of ARM v6 & v7 Architectures
In-Reply-To: <a4ef7565bd6013f56c5c10071bd36739c59768b7.1310544641.git.wolfgang.betz@st.com>
References: <cover.1310544641.git.wolfgang.betz@st.com>
	<a4ef7565bd6013f56c5c10071bd36739c59768b7.1310544641.git.wolfgang.betz@st.com>
Message-ID: <20110714100254.GA20903@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfgang,

On Thu, Jul 14, 2011 at 10:33:10AM +0100, Wolfgang BETZ wrote:
> From: Wolfgang Betz <wolfgang.betz@st.com>
> 
> The aim of this patch is to enable thread support in the context ID register
> (CONTEXTIDR) as it comes with ARM architectures v6 & v7.
> 
>  On ARMv6 & v7, we have the following structure in the context ID:
> 
>    31                         7          0
>    +-------------------------+-----------+
>    |      process ID         |   ASID    |
>    +-------------------------+-----------+
>    |              context ID             |
>    +-------------------------------------+
> 
> - The ASID is used to tag entries in the CPU caches and TLBs.
> - The process ID must be programmed with a unique value that identifies the
>   current process. It is used by the trace logic and the debug logic to
>   identify the process that is running currently.

We also use upper bits (>= 8) to identify the ASID generation, so you can't
just start putting data in there as this will break the rollover logic.

As Russell said previously, I really don't see how this can work with
current CPUs. Maybe you're better off using one of the unused thread ID
registers if you want to do this sort of thing.

Will
