From: vlad.babchuk@gmail.com (Volodymyr Babchuk)
Date: Mon, 7 May 2018 17:54:02 +0300
Subject: [Tee-dev] [PATCH] tee: shm: fix use-after-free via temporarily
 dropped reference
In-Reply-To: <20180507095841.6452-1-jens.wiklander@linaro.org>
References: <20180507095841.6452-1-jens.wiklander@linaro.org>
Message-ID: <CAOcqxo3B1WYvrRqCVw=bDXFBwcCWQcPm3TT1XQB=NcahPcwEUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

On 7 May 2018 at 12:58, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> From: Jann Horn <jannh@google.com>
>
> Bump the file's refcount before moving the reference into the fd table,
> not afterwards. The old code could drop the file's refcount to zero for a
> short moment before calling get_file() via get_dma_buf().
>
> This code can only be triggered on ARM systems that use Linaro's OP-TEE.
>
> Fixes: 967c9cca2cc5 ("tee: generic TEE subsystem")
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>

-- 
WBR Volodymyr Babchuk aka lorc [+380976646013]
mailto: vlad.babchuk at gmail.com
