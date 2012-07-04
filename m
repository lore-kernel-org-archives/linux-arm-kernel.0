From: javier.martin@vista-silicon.com (javier Martin)
Date: Wed, 4 Jul 2012 13:30:39 +0200
Subject: Clock problems in i.MX27 Visstrim M10 (linux-3.5-rc5).
In-Reply-To: <CAOMZO5Bdpe43wSAS-D34LzVA9gAKwGTjsw_1f3iPizVsWJW7kw@mail.gmail.com>
References: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
 <CAOMZO5CeGKJ6kERaCkNE0Cpy2X78CUN_-au5Q+cCtLLjtNXMDg@mail.gmail.com>
 <CACKLOr1oeci84Fs7HTRD2Myie8zjKExA15mxM3z7dkq8QfvDmg@mail.gmail.com>
 <CAOMZO5Bdpe43wSAS-D34LzVA9gAKwGTjsw_1f3iPizVsWJW7kw@mail.gmail.com>
Message-ID: <CACKLOr1OYmoWXCU=Q_0O1H5jYcAGXO11ji6d_j7SjyaLZuygAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 July 2012 13:26, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Jul 4, 2012 at 4:48 AM, javier Martin
> <javier.martin@vista-silicon.com> wrote:
>
>> thanks for the patches. The first one solves the issue with the audio.
>> Now I can do an aplay properly too.
>
> Ok, great.
>
>> However, second patch for the mx2-camera seems that it's not right
>> yet. I get a timeout here:
>
> I see the same here too now. When I sent you the patches yesterday I
> did not have access to the board.
>
> Looking at the mx2_camera.c driver: wouldn't it make more sense to
> handle the emma resources (clocks, irqs, etc) outside of this driver?
> What about doing it in mx2_emmaprp.c instead?

mx2_emmaprp.c is a different driver for the same device. Its a mem2mem
driver that gets frames from memory in one video format and then
outputs frames in another video format. It hasn't got anything to do
with the mx2_camera.c apart from the fact they can't be used at the
same time since they share emma resources.

Regards.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
