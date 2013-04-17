From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Apr 2013 10:48:29 +0100
Subject: [PATCH] Report double word access atomicity on LPAE enabled
 targets through AUXV
In-Reply-To: <20130416172258.GE3770@mudshark.cambridge.arm.com>
References: <C3FF039D-7DE3-4A99-8317-789094095D8B@oracle.com>
 <20130408142406.GL17995@n2100.arm.linux.org.uk>
 <20130408155749.GS17476@mudshark.cambridge.arm.com>
 <CD54D5A4-2E19-49D9-B6E7-051F36AB5DF8@oracle.com>
 <20130416172258.GE3770@mudshark.cambridge.arm.com>
Message-ID: <20130417094829.GA19492@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 06:22:58PM +0100, Will Deacon wrote:
> Patch below...

[...]

> +#define HWCAP_LPAE     (1 << 20)

[...]

> @@ -875,6 +880,7 @@ static const char *hwcap_str[] = {
>         "vfpv4",
>         "idiva",
>         "idivt",
> +       "atomicd",
>         NULL
>  };

You can tell I was in two minds about this, but that string should read
"lpae".

Will
