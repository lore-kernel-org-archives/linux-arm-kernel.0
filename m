From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 23 May 2016 12:26:10 -0700
Subject: [Patch v5 5/8] firmware: qcom: scm: Convert to streaming DMA APIS
In-Reply-To: <1463111221-6963-6-git-send-email-andy.gross@linaro.org>
References: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
 <1463111221-6963-6-git-send-email-andy.gross@linaro.org>
Message-ID: <CAOi56cVB1Z-gO6Dx0KOSr9wiRF3Y9ahDHe0=qT9WW4MdFMhjng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Thu, May 12, 2016 at 8:46 PM, Andy Gross <andy.gross@linaro.org> wrote:
> This patch converts the Qualcomm SCM driver to use the streaming DMA APIs
> for communication buffers.
>
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

This patch has landed in linux-next in the form of commit a551c3dbd689
(firmware: qcom: scm: Convert to streaming DMA APIS), and kernelci.org
found some boot breakage in next-20160523 on apq8064[1] which was
bisected down to this commit.

I reverted this commit on top of next-20160523 and it no longer
builds, so I didn't validate if things boot again with this patch
reverted.

Kevin

[1] https://kernelci.org/boot/all/job/next/kernel/next-20160523/
