From: joseph@codesourcery.com (Joseph Myers)
Date: Tue, 17 May 2016 15:40:47 +0000
Subject: [RFC6 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <573B0A4D.4090704@arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <573B0A4D.4090704@arm.com>
Message-ID: <alpine.DEB.2.20.1605171538040.24255@digraph.polyomino.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 May 2016, Szabolcs Nagy wrote:

> i think even legacy software should be able to deal with 64bit off_t,
> so we could avoid having two sets of filesystem apis or is 64bit-only
> off_t more work to do in linux/glibc?

wordsize-64 directories generally expect 64-bit interfaces.  wordsize-32 
directories generally expect that there are two sets of filesystem APIs 
which are not aliased (at the userspace level - the versions for the 
generic syscall API deal with setting EOVERFLOW in userspace as needed).

The "wordsize" concept is not wonderfully well-defined and could do with 
being split up into multiple better-defined concepts, but that's obvious 
something pretty tricky to get right, involving a very careful analysis of 
the existing code.

-- 
Joseph S. Myers
joseph at codesourcery.com
