From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 04 Nov 2014 14:32:46 +0100
Subject: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
In-Reply-To: <CAMuHMdVjzRJUL4EL1VbbYdys35f9Jz67_QSPriYnccSOnm1tQw@mail.gmail.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <2024276.CFr3nVUAlA@vostro.rjw.lan>
 <CAMuHMdVjzRJUL4EL1VbbYdys35f9Jz67_QSPriYnccSOnm1tQw@mail.gmail.com>
Message-ID: <2649035.CrrTcoPcg3@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 04, 2014 09:20:44 AM Geert Uytterhoeven wrote:
> On Tue, Nov 4, 2014 at 2:43 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > That is quite simple to address, though.  You can register a bus type
> > notifier that will power up the domain on BUS_NOTIFY_ADD_DEVICE events
> > (where the target device belongs to the domain), and do that only for
> > CONFIG_PM_RUNTIME unset (otherwise runtime PM should take care of this).
> 
> Registering a bus type notifier (that will be a platform bus notifier,
> right?) will affect
> all platform devices, not only the on-SoC devices.

Yes it will, but the "is the device in this domain?" check is trivial to do.

Rafael
