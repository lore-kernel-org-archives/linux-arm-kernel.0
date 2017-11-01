From: james.morse@arm.com (James Morse)
Date: Wed, 01 Nov 2017 11:32:57 +0000
Subject: [PATCH v1 0/3] manually add Error Synchronization Barrier at
 exception handler entry and exit
In-Reply-To: <1509563697-6359-1-git-send-email-gengdongjiu@huawei.com>
References: <1509563697-6359-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <59F9B0E9.5090609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu Geng,

On 01/11/17 19:14, Dongjiu Geng wrote:
> Some hardware platform can support RAS Extension, but not support IESB,
> such as Huawei's platform, so software need to insert Synchronization Barrier
> operations at exception handler entry.
> 
> This series patches are based on  James's series patches "SError rework +
> RAS&IESB for firmware first support". In Huawei's platform, we do not
> support IESB, so software needs to insert that.

Surely you don't implement it because your CPU doesn't need it. Can
unrecoverable errors really cross an exception without becoming an SError?

The ESB instruction does the barrier, but it also consumes any pending SError.
As it is this series will silently consume-and-discard uncontainable errors.



Thanks,

James
