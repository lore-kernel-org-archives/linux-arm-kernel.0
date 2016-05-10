From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 9 May 2016 20:52:12 -0500
Subject: linux-next: build failure after merge of the net-next tree
In-Reply-To: <20160510112905.5bffcad8@canb.auug.org.au>
References: <20160510112905.5bffcad8@canb.auug.org.au>
Message-ID: <CAPBZ5QcRiG0w4WsU7rDGSNogH1PSONWSjrZ6fXWb4kdc+BH3JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 May 2016 at 20:29, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the net-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> net/qrtr/smd.c:106:14: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>   .callback = qcom_smd_qrtr_callback,
>               ^
> net/qrtr/smd.c:106:14: note: (near initialization for 'qcom_smd_qrtr_driver.callback')
>
> Caused by commit
>
>   bdabad3e363d ("net: Add Qualcomm IPC router")
>
> interacting with commit
>
>   b853cb9628bf ("soc: qcom: smd: Make callback pass channel reference")
>
> from the arm-soc tree.
>
> I added the following merge fix patch (and it turned out I needed the
> new stubs).

Thanks for fixing this up.  I'll work with Bjorn to get this resolved.
I'll have something up for tomorrow's next pull.


Regards,

Andy Gross
