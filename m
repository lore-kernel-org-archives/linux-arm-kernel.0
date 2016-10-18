From: atull@opensource.altera.com (atull)
Date: Tue, 18 Oct 2016 13:28:08 -0500
Subject: [PATCH v20 02/10] doc: fpga-mgr: add fpga image info to api
In-Reply-To: <CAAtXAHcpwmW_7f2F9vk49hAHpOTs4rk9fFvLzn5zNdPZCy_O7A@mail.gmail.com>
References: <20161017160941.4205-1-atull@opensource.altera.com>
 <20161017160941.4205-3-atull@opensource.altera.com>
 <CAAtXAHcpwmW_7f2F9vk49hAHpOTs4rk9fFvLzn5zNdPZCy_O7A@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1610181323370.20737@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Oct 2016, Moritz Fischer wrote:

> Hi Alan,
> 
> couple of nits inline and some comments on ordering the patches ;-)
> 
> On Mon, Oct 17, 2016 at 6:09 PM, Alan Tull <atull@opensource.altera.com> wrote:
> > This patch adds a minor change in the FPGA Mangager API
> 
> s/Mangager/Manager/

Yup!

> 
> > to hold information that is specific to an FPGA image
> > file.  This change is expected to bring little, if any,
> > pain.
> >
> > An FPGA image file will have particulars that affect how the
> > image is programmed to the FPGA.  One example is that
> > current 'flags' currently has one bit which shows whether the
> > FPGA image was built for full reconfiguration or partial
> > reconfiguration.  Another example is timeout values for
> > enabling or disabling the bridges in the FPGA.  As the
> > complexity of the FPGA design increases, the bridges in the
> > FPGA may take longer times to enable or disable.
> 
> According for the current ordering bridges are not yet defined if we
> merge patches in this order?
> Not terrible imho, but I thought I'd point it out. Would swapping the
> order make sense?

Probably, yes.

> 
> I also think [5/10] should be squashed together with this commit to
> make it an atomic change.

So far my bindings and code have gone in separately.
Bindings through Rob and code through Greg KH or Dinh.

> 
> Apart from my comments above feel free to add my Acked-by
> 
> Thanks for keeping this going,
> 
> Moritz
> 

Thanks for all the code reviews!

Alan
