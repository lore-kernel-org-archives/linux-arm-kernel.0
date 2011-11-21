From: jochen@scram.de (Jochen Friedrich)
Date: Mon, 21 Nov 2011 15:44:09 +0100
Subject: [PATCH] ARM: sa1100: refactor sa1100 serial driver
In-Reply-To: <1321822742.17619.6.camel@Joe-Laptop>
References: <1321821127-32231-1-git-send-email-jochen@scram.de>
 <1321822068.17619.3.camel@Joe-Laptop> <1321822742.17619.6.camel@Joe-Laptop>
Message-ID: <4ECA63B9.3010509@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

> I get these bounce messages a lot.
> Any clue how to resolve them?
>
> Failed to deliver to 'jochen at scram.de'
> SMTP module(domain @206.117.179.246:scram.de) reports:
>   return-path address<joe@perches.com>  rejected by mail1.scram.de:
>   ?c?s?1
0       U
TR10U
ANKARA1V0TU

This seems to be TLS related:

Nov 20 21:47:51 amavis postfix/smtpd[9708]: connect from perches-mx.perches.com[206.117.179.246]
Nov 20 21:47:51 amavis postfix/smtpd[9708]: setting up TLS connection from perches-mx.perches.com[206.117.179.246]
Nov 20 21:47:53 amavis postfix/smtpd[9708]: SSL_accept error from perches-mx.perches.com[206.117.179.246]: 0
Nov 20 21:47:53 amavis postfix/smtpd[9708]: warning: TLS library problem: 9708:error:1409441A:SSL routines:SSL3_READ_BYTES:tlsv1 alert decode error:s3_pkt.c:1086:SSL alert number 50:
Nov 20 21:47:53 amavis postfix/smtpd[9708]: lost connection after STARTTLS from perches-mx.perches.com[206.117.179.246]
Nov 20 21:47:53 amavis postfix/smtpd[9708]: disconnect from perches-mx.perches.com[206.117.179.246]
Nov 20 21:47:53 amavis postfix/smtpd[13209]: connect from unknown[188.48.229.10]

Thanks,
Jochen
