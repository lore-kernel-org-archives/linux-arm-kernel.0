From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 10 Jun 2011 09:46:42 +0530
Subject: kernel - userspace shared memory
In-Reply-To: <BANLkTikGHoBTDyPN7T7N88DfMF1F322T2A@mail.gmail.com>
References: <BANLkTikGHoBTDyPN7T7N88DfMF1F322T2A@mail.gmail.com>
Message-ID: <4DF19AAA.40309@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2011 10:47 PM, Zoltan Devai wrote:
> Hi all,
> 
> We are having a kernel driver and a userspace application that
> communicates via shared memory. The problem is, that when the userspace
> application modifies some data in the shared memory, this modification
> is not "visible" when the kernel driver takes a look at that memory
> location (specifically this code is in a kernel timer function).
> Actually, the modification is sometimes seen, sometimes not,
> which suggests that we are having some kind of cache coherency issue.
> The strange thing is, that AFAIK we have disabled caching on the pages
> where the shared memory resides.

Which core are you using? One problem that i am aware of is, on ARMv7
"Multiple mappings of memory with different attributes is not supported".
And the result of such is unspecified.

And for that we need to allocate memory with dma_mmap_writecombine() and remap it
for virtual space with dma_mmap_writecombine().

HTH.

-- 
viresh
