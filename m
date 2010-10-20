From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Oct 2010 01:19:12 -0200
Subject: [PATCH 1/1] Mx35pdk: enable debug board support
In-Reply-To: <AANLkTimdEhO9m7HW-TNxPaEVk85GDEThyn_DanJ_CZ+i@mail.gmail.com>
References: <1287129633-9244-1-git-send-email-jgq516@gmail.com>
	<AANLkTikY=wBiJZ0NFKJKX-TTKRAj_LWmaxD-BpuPNYzL@mail.gmail.com>
	<AANLkTi=jyQDNmGK1-VB_xOP8H4+jXNwS6oHgft90gGLW@mail.gmail.com>
	<AANLkTim65XWxn_Mc59PXbiOOqUVMDNqeweU38y_3R7_X@mail.gmail.com>
	<AANLkTi=upCD4iKhkvkzk7Kcb++OYR3pZTQw4i9fTEkFg@mail.gmail.com>
	<AANLkTimqGRiP1QUtNdJuyQMN_bf+4R7dEn-LNd7bhAu4@mail.gmail.com>
	<AANLkTinD_LWiqh9Pc-jOsKArfBBLAYeExgfdNMb5CaAT@mail.gmail.com>
	<AANLkTimJ_5ci9MnyxhUXemAc6YJGb2KXR2q-QX-MKEHo@mail.gmail.com>
	<AANLkTimdEhO9m7HW-TNxPaEVk85GDEThyn_DanJ_CZ+i@mail.gmail.com>
Message-ID: <AANLkTikmDhpxKM7zXLQsihjc=mJ_59nbqLE1AGZfvzqU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xiao,

On Tue, Oct 19, 2010 at 11:45 PM, xiao jiang <jgq516@gmail.com> wrote:
>
> The patch is ok for me too,? and? the definition of EXPIO_PARENT_INT is
> similar like mx51_3ds board
> as I had said before.
> But since mxc_expio_init() should be return 0 if the debug board is
> detected, We should use
> mxc_expio_init(**_BASE_ADDR, EXPIO_PARENT_INT) other than
> !mxc_expio_init(**_BASE_ADDR, EXPIO_PARENT_INT), right?? The same issue also
> existed in mach-mx31_3ds.c.

mxc_expio_init returns 0 if the debug board is detected.
!mxc_expio_init returns 1 and print the error message.

So this is correct. I also get a message during the kernel boot saying
that the debug board was succesfully detected.

If you want, please resubmit a v2 of your original patch and also add my:
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Regards,

Fabio Esevam
