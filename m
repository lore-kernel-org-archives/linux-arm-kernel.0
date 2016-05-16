From: sricharan@codeaurora.org (Sricharan)
Date: Mon, 16 May 2016 11:29:25 +0530
Subject: [PATCH V2 2/2] drivers: i2c: qup: Fix error handling
In-Reply-To: <20160513115021.GK1778@katana>
References: <1462534274-28925-1-git-send-email-sricharan@codeaurora.org>
 <1462534274-28925-3-git-send-email-sricharan@codeaurora.org>
 <20160513114823.GJ1778@katana> <20160513115021.GK1778@katana>
Message-ID: <002201d1af38$1eb3e330$5c1ba990$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> > > Among the bus errors reported from the QUP_MASTER_STATUS register
> > > only NACK is considered and transfer gets suspended, while other
> > > errors are ignored. Correct this and suspend the transfer for other
> > > errors as well. This avoids unnessecary 'timeouts' which happens
> > > when waiting for events that would never happen when there is
> > > already an error condition on the bus.
> > >
> > > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > > Reviewed-by: Andy Gross <andy.gross@linaro.org>
> >
> > Please check Documentation/i2c/fault-codes for proper fault codes.
> 
    Ok, Thanks for pointing this out. So, for NACK I think it is more
appropriate to
    return -ENXIO and -EIO for other errors. Will correct this.

> And while we are here: NACK is not an error but a valid response. Can you
> remove the dev_err related to that? Otherwise tools like i2cdetect will
> probably flood your log.
  Ok, will correct this.

Regards,
 Sricharan         
