From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 13:56:09 +0100
Subject: [PATCH 3/3] net: mvneta: adjust multiline comments to net/ style
In-Reply-To: <50AA2AD4.6030007@mvista.com>
References: <1353322834-16952-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353322834-16952-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <50AA2AD4.6030007@mvista.com>
Message-ID: <20121119135609.3808b1c7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sergei Shtylyov,

On Mon, 19 Nov 2012 16:49:24 +0400, Sergei Shtylyov wrote:

> > -/*
> > - * The two bytes Marvell header. Either contains a special value used
> > +/* The two bytes Marvell header. Either contains a special value used
> 
>     Why the heck you're doing this? It's the preferred style, see 
> Documentation/CodingStyle, chapter 8.

No. Please read Documentation/CodingStyle, chapter 8 entirely:

===============================================================
The preferred style for long (multi-line) comments is:

        /*
         * This is the preferred style for multi-line
         * comments in the Linux kernel source code.
         * Please use it consistently.
         *
         * Description:  A column of asterisks on the left side,
         * with beginning and ending almost-blank lines.
         */

For files in net/ and drivers/net/ the preferred style for long
(multi-line) comments is a little different.

        /* The preferred comment style for files in net/ and drivers/net
         * looks like this.
         *
         * It is nearly the same as the generally preferred comment style,
         * but there is no initial almost-blank line.
         */
===============================================================

Seen the second part?

Please also see scripts/checkpatch.pl:

                if ($realfile =~ m@^(drivers/net/|net/)@ &&
                    $rawline =~ /^\+[ \t]*\/\*[ \t]*$/ &&
                    $prevrawline =~ /^\+[ \t]*$/) {
                        WARN("NETWORKING_BLOCK_COMMENT_STYLE",
                             "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
                }

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
