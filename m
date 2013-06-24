From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Jun 2013 00:26:21 +0200
Subject: [RFC PATCH v2 04/12] dmaengine: PL08x: Add support for PL080S
 variant
In-Reply-To: <1371933764-24875-5-git-send-email-tomasz.figa@gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <1371933764-24875-5-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdbLr4Au_WeGU1xM7H4cW70udVjZN-zQKe1+grYyqkyBsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 10:42 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> @@ -96,7 +96,11 @@ enum {
>         PL080_LLI_LLI,
>         PL080_LLI_CCTL,
>
> -       PL080_LLI_WORDS
> +       PL080_LLI_WORDS,
> +
> +       PL080S_LLI_CCTL2 = PL080_LLI_WORDS,
> +
> +       PL080S_LLI_WORDS = 8
>  };

I still think it's better to just #define these and write
some comments. Now I have to think backwards that
I am the compiler enumerating these things and it's all
a bit confusing.

Apart from that it looks nice.

Yours,
Linus Walleij
