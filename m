From: geoff@infradead.org (Geoff Levand)
Date: Wed, 12 Nov 2014 13:54:41 -0800
Subject: [PATCH 08/10] arm64/kexec: Add core kexec support
In-Reply-To: <CAFdej022x_XxqR3NJJkXD60wQHt8Yvs3vZ7nbMQczHP+hWXfCA@mail.gmail.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <c8e8a3378f028e54e21931bc7f3d62c48725d5c7.1414099246.git.geoff@infradead.org>
 <CAFdej022x_XxqR3NJJkXD60wQHt8Yvs3vZ7nbMQczHP+hWXfCA@mail.gmail.com>
Message-ID: <1415829281.15847.16.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun, Dave,

On Fri, 2014-11-07 at 16:31 +0530, Arun Chandran wrote:
> I have issue in flushing with L3 cache on . kexec does not reboot with L3.
> Is the above logic of flushing (clean + invalidate) after copying the
> image data is correct? Is there exist the danger of image data being
> overwritten by invalid cache lines?
> 
> I tried with only invalidate(dc ivac); but that also not seems to be
> working.
> 
> Finally I moved the entire flushing logic before copying then
> things started working. Please see the code change below.

I added this with some minor changes.  Please let me know if
it works for you.

-Geoff
