From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 12 Aug 2015 17:35:04 -0500
Subject: [Linaro-acpi] [PATCH 1/5] ACPI: add in a bad_madt_entry()
 function to eventually replace the macro
In-Reply-To: <1438894770-31163-2-git-send-email-al.stone@linaro.org>
References: <1438894770-31163-1-git-send-email-al.stone@linaro.org>
 <1438894770-31163-2-git-send-email-al.stone@linaro.org>
Message-ID: <CAOZdJXVZomskfpvEjmDUiptW3SndJWvfKyzd9SwJp3dh7h3pig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 6, 2015 at 3:59 PM, Al Stone <al.stone@linaro.org> wrote:
> +       while (ms->num_types != 0) {
> +               if (ms->major_version == major &&
> +                   ms->minor_version == minor &&
> +                   ms->madt_version == madt->header.revision)
> +                       break;
> +               ms++;
> +       }
> +       if (!ms) {

Shouldn't this be

  if (!ms->num_types) {

instead?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
