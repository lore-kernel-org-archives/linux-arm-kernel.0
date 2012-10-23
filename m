From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Oct 2012 13:03:33 +0300
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <CACRpkdbhCS-Vb0DtbTZQ_Zw_8SOh3Bqutme3Y2-QrxNqvMiNNw@mail.gmail.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121022155028.GA13791@core.coreip.homeip.net>
 <CACRpkdaQ1WfRWrx=RXMVkeFtwdERJsOpVa3DaXBTU2KZdgqhRQ@mail.gmail.com>
 <508664CA.7000601@ti.com>
 <CACRpkdbhCS-Vb0DtbTZQ_Zw_8SOh3Bqutme3Y2-QrxNqvMiNNw@mail.gmail.com>
Message-ID: <20121023100333.GA24418@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 23, 2012 at 12:04:01PM +0200, Linus Walleij wrote:
> On Tue, Oct 23, 2012 at 11:35 AM, Benoit Cousson <b-cousson@ti.com> wrote:
> > On 10/23/2012 11:13 AM, Linus Walleij wrote:
> 
> >> So Sourav, please tell us a bit about your plans for this
> >> and other drivers!
> >
> > Yeah, this idea is to handle pinctrl from all the drivers, and
> > potentially change the mode during suspend when it is relevant.
> 
> I'm leaning toward the same approach for ux500.
> 
> But it appears that shmobile prefer to get all resources using
> bus notifiers.
> 
> So we need to form some kind of consensus ... or live with
> the fact that different systems do it different ways. Which will
> explode the day we need to use a driver on two systems,
> each using the other approach :-)

I much prefer having drivers explicitly manage all their resources,
which would mean that pinctrl calls need to be done on probe() and, if
necessary, during suspend()/resume().

Using bus notifiers for that is quite a hack IMHO.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/339bb2ed/attachment.sig>
