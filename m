From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 4 Jul 2012 08:26:21 -0300
Subject: Clock problems in i.MX27 Visstrim M10 (linux-3.5-rc5).
In-Reply-To: <CACKLOr1oeci84Fs7HTRD2Myie8zjKExA15mxM3z7dkq8QfvDmg@mail.gmail.com>
References: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
 <CAOMZO5CeGKJ6kERaCkNE0Cpy2X78CUN_-au5Q+cCtLLjtNXMDg@mail.gmail.com>
 <CACKLOr1oeci84Fs7HTRD2Myie8zjKExA15mxM3z7dkq8QfvDmg@mail.gmail.com>
Message-ID: <CAOMZO5Bdpe43wSAS-D34LzVA9gAKwGTjsw_1f3iPizVsWJW7kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2012 at 4:48 AM, javier Martin
<javier.martin@vista-silicon.com> wrote:

> thanks for the patches. The first one solves the issue with the audio.
> Now I can do an aplay properly too.

Ok, great.

> However, second patch for the mx2-camera seems that it's not right
> yet. I get a timeout here:

I see the same here too now. When I sent you the patches yesterday I
did not have access to the board.

Looking at the mx2_camera.c driver: wouldn't it make more sense to
handle the emma resources (clocks, irqs, etc) outside of this driver?
What about doing it in mx2_emmaprp.c instead?

Regards,

Fabio Estevam
