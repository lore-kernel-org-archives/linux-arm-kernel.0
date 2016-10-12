From: qiyaoltc@gmail.com (Yao Qi)
Date: Wed, 12 Oct 2016 12:16:29 +0100
Subject: [PATCH 3/4] arm64: Allow hw watchpoint of length 3,5,6 and 7
In-Reply-To: <d6ebb3e9776154da4c1a41f17446e9e31c891a7d.1476251587.git.panand@redhat.com>
References: <cover.1476251587.git.panand@redhat.com>
 <d6ebb3e9776154da4c1a41f17446e9e31c891a7d.1476251587.git.panand@redhat.com>
Message-ID: <CAH=s-PNFESLA6TTem-49g0CKsjpKOsj1XYfPUXz6YbEfMWXqXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2016 at 6:58 AM, Pratyush Anand <panand@redhat.com> wrote:
> Since, arm64 can support all offset within a double word limit. Therefore,
> now support other lengths within that range as well.

How does ptracer (like GDB) detect kernel has already supported all byte
address select values?  I suppose ptrace(NT_ARM_HW_WATCH, ) with
len is 3 or 5 fail on current kernel but is of success after your patches
applied.

GDB is aware of the byte address select limitation in kernel, so it always
sets 1,2,4,8 in len in ctrl.  GDB needs to know whether the limitation is still
there or not.

-- 
Yao (??)
