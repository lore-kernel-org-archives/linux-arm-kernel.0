From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Sat, 24 Nov 2012 10:44:36 +0530
Subject: [PATCH 1/8 v3] DMA: PL330: use prefix in reg names to build under
 x86
In-Reply-To: <1353718436-20194-1-git-send-email-ciminaghi@gnudd.com>
References: <CAKohpokUHv96wutU1ZLxxnndR3wfTr3kjh3UKREtuiVV-V8+EA@mail.gmail.com>
 <1353718436-20194-1-git-send-email-ciminaghi@gnudd.com>
Message-ID: <CAJe_ZhcGmeTviV8v8eCMFZTWLnOb24_kVa1TkZF=9oyc6=vA4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 November 2012 06:23, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:
> From: Alessandro Rubini <rubini@gnudd.com>
>
> This driver would not compile if ARM_AMBA is selected under x86,
> because "CS" and "DS" are already defined there.  But AMBA
> is used in the x86 world by a PCI-to-AMBA bridge, to be submitted.
>
> The patch just adds the "PL330_" prefix to all register and bit fields,
> so it can be built by randomconfig after ARM_AMBA appears within x86.

Prefixing only CS and DS should be do the job.
Why do we have to make every symbol noisy with PL330_ ?
