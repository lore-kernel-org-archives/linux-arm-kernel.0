From: cohuck@redhat.com (Cornelia Huck)
Date: Tue, 29 Aug 2017 13:26:35 +0200
Subject: [PATCH RFC v3 1/9] KVM: s390: optimize detection of started vcpus
In-Reply-To: <20170821203530.9266-2-rkrcmar@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-2-rkrcmar@redhat.com>
Message-ID: <20170829132635.23941a6f.cohuck@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Aug 2017 22:35:22 +0200
Radim Kr?m?? <rkrcmar@redhat.com> wrote:

> We can add a variable instead of scanning all online VCPUs to know how
> many are started.  We can't trivially tell which VCPU is the last one,
> though.
> 
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Radim Kr?m?? <rkrcmar@redhat.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  1 +
>  arch/s390/kvm/kvm-s390.c         | 39 +++++++++++++++------------------------
>  2 files changed, 16 insertions(+), 24 deletions(-)

Modulo the bug noticed by Christian, I think this looks good.
