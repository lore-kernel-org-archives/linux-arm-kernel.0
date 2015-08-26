From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 26 Aug 2015 10:38:42 -0500
Subject: [PATCH v2 1/5] ACPI: add in a bad_madt_entry() function to
 eventually replace the macro
In-Reply-To: <1440022048-6285-2-git-send-email-al.stone@linaro.org>
References: <1440022048-6285-1-git-send-email-al.stone@linaro.org>
 <1440022048-6285-2-git-send-email-al.stone@linaro.org>
Message-ID: <CAOZdJXXCnb7ChYqh-QYptTQBmfESDPaauThHyu8Dav6Qs_+4Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 5:07 PM, Al Stone <al.stone@linaro.org> wrote:
> +                               pr_err("Variable length MADT subtable %d is wrong size: %d\n",
> +                                      entry->type, entry->length);
> +                               return 1;
> +                       }
> +               }
> +       } else {
> +               if (entry->length != len) {
> +                       pr_err("MADT subtable %d is wrong size: %d\n",
> +                              len, entry->type);

Can we make these a little more descriptive?

pr_err("Variable length MADT subtable type %d is wrong size: %d,
should be %d\n",
      entry->type, entry->length, len);

pr_err("MADT subtable type %d is wrong size: %d, should be %d\n",
      entry->type, entry->length, len);




-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
