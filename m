From: b.a.stenning@gmail.com (Bruce Stenning)
Date: Tue, 13 Dec 2011 12:22:22 +0000
Subject: Bad page state BUG triggered by init process (kernel 3.1.2)
In-Reply-To: <CAN_pD_CfXh=savgYk21vo8+5E8ScfSgVsu7m4VjBLVwdPop+SA@mail.gmail.com>
References: <CAN_pD_CfXh=savgYk21vo8+5E8ScfSgVsu7m4VjBLVwdPop+SA@mail.gmail.com>
Message-ID: <CAN_pD_BA8g=G3nvdiu0bNp0gqJU=LF4N4POGh9E5qfN_ubbfdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> BUG: Bad page state in process busybox ?pfn:00000
> page:c0291000 count:0 mapcount:0 mapping: ?(null) index:0x0
> page flags: 0x200(arch_1)

After some experimentation, the diagnostics provided by CONFIG_DMA_API_DEBUG
have shown up problems in the IOP ADMA self-tests (inconsistencies between
map and unmap of DMA pages) and disabling these self-tests removes the
DMA API use warnings and prevents the bad page state bug from triggering
when init runs.

Bruce.
