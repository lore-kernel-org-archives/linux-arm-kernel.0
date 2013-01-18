From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Fri, 18 Jan 2013 18:40:57 +0530
Subject: [PATCH] ARM: SAMSUNG: Gracefully exit on suspend failure
In-Reply-To: <00ab01cdeeca$02a75e60$07f61b20$@samsung.com>
References: <1357729952-14881-1-git-send-email-a.kesavan@samsung.com>
 <00ab01cdeeca$02a75e60$07f61b20$@samsung.com>
Message-ID: <CAM4voanPGUdNKTGuTppVP8fF8+Ydt-ahjyHhqDF2tmxWKbB9Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> -     panic("sleep resumed to originator?");
>> +     pr_err("Failed to suspend the system\n");
>> +     return -EBUSY;
>
> This can be happened under non-error situation, so this should be:
>
> +       pr_info("sleep resumed to originator?");
> +       return 1; /* abort suspend */
>
Will re-post with suggested changes.

Abhilash
