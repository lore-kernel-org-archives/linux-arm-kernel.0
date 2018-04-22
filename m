From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 22 Apr 2018 10:05:21 +0200
Subject: [PATCHv3 11/11] arm64: docs: document pointer authentication
In-Reply-To: <20180417183735.56985-12-mark.rutland@arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
 <20180417183735.56985-12-mark.rutland@arm.com>
Message-ID: <20180422080520.GC17875@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> @@ -205,6 +205,14 @@ Before jumping into the kernel, the following conditions must be met:
>      ICC_SRE_EL2.SRE (bit 0) must be initialised to 0b0.
>    - The DT or ACPI tables must describe a GICv2 interrupt controller.
>  
> +  For CPUs with pointer authentication functionality:
> +  - If EL3 is present:
> +    SCR_EL3.APK (bit 16) must be initialised to 0b1
> +    SCR_EL3.API (bit 17) must be initialised to 0b1
> +  - If the kernel is entered at EL1:
> +    HCR_EL2.APK (bit 40) must be initialised to 0b1
> +    HCR_EL2.API (bit 41) must be initialised to 0b1
> +

0b1 is quite confusing way to write 1.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180422/31fde743/attachment.sig>
