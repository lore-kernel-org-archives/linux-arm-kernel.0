From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Feb 2016 16:10:21 +0100
Subject: [PATCH] ARM: ks8695: fix __initdata annotation
In-Reply-To: <20160209113624.GU13664@pengutronix.de>
References: <1454941509-2773774-1-git-send-email-arnd@arndb.de>
 <18237653.x9qPaNvtCU@wuerfel> <20160209113624.GU13664@pengutronix.de>
Message-ID: <3182431.K4Gl4054Gk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 February 2016 12:36:24 Uwe Kleine-K?nig wrote:
> Having the attribute list after the declarator isn't recommended as
> explicit as I remember having read it somewhere in the gcc docs.
> 
>         info gcc "Attribute Syntax"
> 
> has:
> 
>          An attribute specifier list may appear immediately before a declarator
>         (other than the first) in a comma-separated list of declarators in a
>         declaration of more than one identifier using a single list of
>         specifiers and qualifiers.  Such attribute specifiers apply only to the
>         identifier before whose declarator they appear.  For example, in
> 
>              __attribute__((noreturn)) void d0 (void),
>                  __attribute__((format(printf, 1, 2))) d1 (const char *, ...),
>                   d2 (void)
> 
>         the 'noreturn' attribute applies to all the functions declared; the
>         'format' attribute only applies to 'd1'.
> 
> (Funny enough, in the example the attribute specifier list doesn't
> appear *immediately* before the declarator d0.)
> 
> This might be interpreted as "usually the attribute specifier list appears
> after the declarator". Other than that I cannot find an explict
> recommended placement in the docs. The examples in
> 
>         info gcc "Variable Attributes"
> 
> always have the attribute list after the declarator.

Ok, thanks for the detailed answer, I've fixed it up locally now.
I guess I'm applying the patch in arm-soc directly at some point
and will use the line you suggested after some more testing:

 static struct map_desc og_io_desc[] __initdata = {


	Arnd
