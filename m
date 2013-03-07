From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 8 Mar 2013 07:29:32 +0800
Subject: [PATCH 1/6] platform-drivers: msm: add single-wire serial bus
 interface (SSBI) driver
In-Reply-To: <8yafw07ujr3.fsf@huya.qualcomm.com>
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
 <1362616187-21089-2-git-send-email-davidb@codeaurora.org>
 <20130307013008.GA2910@kroah.com>
 <8yawqtjvl8y.fsf@huya.qualcomm.com>
 <20130307060117.GA31687@kroah.com>
 <8yafw07ujr3.fsf@huya.qualcomm.com>
Message-ID: <20130307232932.GE10304@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 10:50:40AM -0800, David Brown wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> >> Without this device, the PMIC drivers won't work, regulators can't be
> >> turned on, and most of the other devices won't work.  I can try if it
> >> can still be made a module, and it might be good at exercising the
> >> deferred probe mechanism.
> >
> > If the PMIC drivers are dependant on the symbols in this module, there
> > should not be any problems, right?
> 
> The PMIC drivers directly will be, but the users of gpios/irqs and
> regulators coming from the PMIC will only depend on the generic APIs for
> this.  In theory, the deferred probe should handle this, and it might
> be useful for testing.
> 
> I can allow it to be a module, although I don't picture that really
> being a useful configuration.

It will allow this to get multi-arch build testing at the very least, a
very valuable thing as time goes on.  You can always specify this as 'Y'
in your defconfig for your board.

thanks,

greg k-h
