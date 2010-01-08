From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 8 Jan 2010 09:57:34 +0800
Subject: [patch] fix strange characters in zaurus gpio .desc
In-Reply-To: <f17812d71001071744m2dccc09btf0ea2a63ccd33b55@mail.gmail.com>
References: <20100107203104.GA22681@elf.ucw.cz>
	<1262903483.5722.7.camel@utx.utx.cz>
	<f17812d71001071744m2dccc09btf0ea2a63ccd33b55@mail.gmail.com>
Message-ID: <f17812d71001071757w23805098udf53f77f1cfebc5a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is bothering me again and again, looks Dirk's ISP being problematic:

This message was created automatically by mail delivery software.

A message that you sent could not be delivered to one or more of
its recipients. The following addresses failed:

 <d.opfer@web.de>

SMTP error from remote server after RCPT command:
host mx-ha01.web.de[217.72.192.149]:
550 <d.opfer@web.de> Benutzer hat das Speichervolumen ueberschritten.
/ User has exhausted allowed storage space.


--- The header of the original message is following. ---

Received-SPF: pass (mxbap3: domain of gmail.com designates
74.125.92.150 as permitted sender) client-ip=74.125.92.150;
envelope-from=eric.y.miao at gmail.com; helo=qw-out-1920.google.com;
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
       by mx.kundenserver.de (node=mxbap3) with ESMTP (Nemesis)
       id 0Llo92-1O27bT0IgC-00Zz6A for Dirk at opfer-online.de; Fri, 08
Jan 2010 02:44:31 +0100
Received: by qw-out-1920.google.com with SMTP id 5so4551775qwc.0
       for <Dirk@opfer-online.de>; Thu, 07 Jan 2010 17:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
       d=gmail.com; s=gamma;
       h=domainkey-signature:mime-version:received:in-reply-to:references
        :from:date:message-id:subject:to:cc:content-type;
       bh=6LZ0KtSH4ZKYLj8sPFkD0MWZ4EfaPMGUEJBX9IU6Szw=;
       b=hDpznbB+Arp9dpDt9CnKONy9R2nxu790sM+B+BgiJCFK0FlBrZNXEDKmyGso///gIl
        bfc5Y0xIlFMuQ5yYDxvunWvcPh/NDV6d4xxZAfL0LrUj9gU07gi4c18vpA+pIrtdQKZe
        GmV20H9foiS59B1743oVw37eOPH61rza05OtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
       d=gmail.com; s=gamma;
       h=mime-version:in-reply-to:references:from:date:message-id:subject:to
        :cc:content-type;
       b=rcbVtRDX2DsM6jomSpcitZ+m+I0mT5aViVU07Kg495AC23JsL+WhQ1Zqafay/5OW2+
        JvOE7UW8ncRW87grW37mjNNv/gDuX926IHhZsJq7jXpJjhwKFuP86uWjW2ATj3xG/p6C
        uu+aSpvO0zWb0AW4xsGQXNMAfhgTc/ld8y2OY=
MIME-Version: 1.0
Received: by 10.229.128.90 with SMTP id j26mr1069163qcs.103.1262915070102;
       Thu, 07 Jan 2010 17:44:30 -0800 (PST)
In-Reply-To: <1262903483.5722.7.camel@utx.utx.cz>
References: <20100107203104.GA22681@elf.ucw.cz>
<1262903483.5722.7.camel@utx.utx.cz>
From: Eric Miao <eric.y.miao@gmail.com>
Date: Fri, 8 Jan 2010 09:44:10 +0800
Message-ID: <f17812d71001071744m2dccc09btf0ea2a63ccd33b55@mail.gmail.com>
Subject: Re: [patch] fix strange characters in zaurus gpio .desc
To: Stanislav Brabec <utx@penguin.cz>
Cc: Pavel Machek <pavel@ucw.cz>, rpurdie at rpsys.net, lenz at cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
Dirk at opfer-online.de, arminlitzel at web.de,
       Cyril Hrubis <metan@ucw.cz>, thommycheck at gmail.com,
       linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
dbaryshkov at gmail.com,
       omegamoon at gmail.com, zaurus-devel at lists.linuxtogo.org,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
